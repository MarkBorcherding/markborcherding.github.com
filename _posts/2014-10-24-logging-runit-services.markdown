---
layout: post
title:  "Logging Runit Services"
date:   2014-10-24
categories: runit linux devops
tags:
image: /assets/article_images/2014-10-24-logging-runit-services/logs.jpg
---

We've recently re-done how our applications are crafting their logs. Our previous setup was a mess. We had several nodes, all logging to four or five different files. This proved challenging to debug.

*TL; DR; If you create a `/etc/service/my_service/log/run` executable, it will receive as input all the `stdout` of the service to log however you wish.*

# The Graylog2 Server
In an attempt to consolidate our log we decided to send all the logs to a [Graylog2 Server][Graylog2]. The [docs at Graylog about how to do this][graylog2_rails] are pretty straightforward. Basically it just says to replace your logger with an endpoint that sends the logs to the Graylog2 server. That's fine and it works, but we still wanted out logs on the disk of the server for now.

# Log4r

[Log4r][log4r] was the first thing we tried. We setup multiple outputters to log to disk, and send them via UDP to the log server. This worked, but Log4r feels really clunky to use. Also, we have to configure every app, and all background services to log with log4r. We did this. We ran it in production and it workes, it's just feels clunky.

# Syslog
We then switched from logging to disk and sending to log server, to just logging to syslog, and sending syslog to the log server. This removed log4r, and its complexities. Great! We swap out the log4r logger with a new `Syslogger` logger. This worked well. We tag each app so we can pull syslog apart and send it to log server. This still has unwanted duplication. Everything now needs to get the `syslogger` gem and wire it up. This include Unicorn, which logs outside the context of our Rails app. This still isn't ideal.

## This si a h2

### h3

#### h4

# Stdout
Finally things started to make sense. *Log everything to `stdout` and pipe that to `syslog` in the script that started it (e.g. `/etc/service/my_app/run`). Perfect. We drop the `syslogger` gem. There is no difference between production and development logging. Simple scripts can still log to syslog. I should just be able to change the startup script to something like

    #!/bin/sh
    exec 2>&1
    exec bundle exec unicorn | logger -t unicorn

....just one problem. The process that `runit` monitors is a process that pipes the output of the `unicorn` to the `logger`. This isn't good because the and signals sent via `sv` end up at the pipe, and not unicorn. Unicorn ends up being orphaned if you run a stop, and then bad things happen.

# Syslog with some magic

We found a way to launch `logger` in the background and send the output of the controlled program to logger via a randomly created pipe.

    #!/bin/sh


Fancy huh?....but totally unnecessary.

# Runit ...RTFM

Turns out logging is a rather common requirement for a service. Runit has a mechanism for handling it. An executable file named `run` in `/etc/service/my_app/log`. This will receive all the `stdout` of the `runit` service. Runit provides a program `svlogd` to help log to disk, but we just piped to `logger` and sent it to `syslog`.


