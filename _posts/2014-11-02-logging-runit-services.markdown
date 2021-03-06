---
layout: post
title: Logging Runit Services
published: true
categories: devops
tags: runit devops
image: /assets/article_images/2014-11-02-logging-runit-services/logs.jpg
image_credit: https://www.flickr.com/photos/paukrus/9826882836
---

Recently we started logging everything to STDOUT and pipeing to `syslog`.  This is simpler than collating several different log files.  Checkout [Better Rails Logging](https://pooreffort.com/blog/better-rails-logging/) for more motivations behind logging _everything_ to STDOUT.

Making the applications log to STDOUT was the easy part. It's built into Ruby.

{% highlight ruby %}
Rails.logger = Logger.new(STDOUT)
{% endhighlight %}

Anywhere else that you want to log to a file, we're logging to `/dev/stdout`.

Getting things to Syslog, at first seemed a little more complicated. After a few trial and errors we ended up doing something like the following.

{% highlight bash %}
# location of named pipe
named_pipe=/tmp/$$.tmp

# remove pipe on the exit signal
trap "rm -f $named_pipe" EXIT

# create named pipe
mknod $named_pipe p

# start logger process in background with stdin coming from
# named pipe also tell logger to append the script name to the
# syslog messages

# so we know where they came from
logger $named_pipe -t "my_app" &

# redirect stderr and stdout to named_pipe
exec 1$named_pipe 2>&1
exec my_app"
{% endhighlight %}

This works and is rather straightforward, but there is an easier way.

Create the directory `/etc/service/my_app/log`. In there drop an executable script called `run` that looks like this.

{% highlight bash %}
#!/bin/bash
exec logger -t "my_app"
{% endhighlight %}

And change your start script to be the following.
{% highlight bash %}
#!/bin/bash
exec my_app 2>&1
{% endhighlight %}

The `log` program will receive the STDOUT of the runit service and that output will end up on syslog.

