---
layout: post
title: "Terse Trigger.io Logging"
description: ""
category:
tags: []
---

I've really been digging [Trigger.io](http://trigger.io). We're really rocking our app. There are few areas that Trigger could definitely improve. Debug
logging is one of those. They have their own tool called Catalyst which exports the developer console of the simulator's app to your browser. I haven't
been able to get that to work with out AngularJS app, so I'm stuck with the terminal output...which is pretty terrible. It's impossible to make sense of
it since you're sifting through lines of noise to find the few bits that actually make sense. It's terrible. I won't event give you an example, because
if you're using it, you know how bad it is.

So, let's fix it. We're using Yeoman and running out app outside of Trigger.io most of the time. We're also using AngularJS so we can inject some services
for logging rather than calling the `forge.logging.log` directly. So let's create that service.


{% highlight coffeescript %}
# I don't like having the forge namespace scattered everywhere
# just to do logging. This helps with that and lets us just use
# logging as an Angular service
angular.module('nb').service 'log', (forge) ->


  # we are exposing all the standard console logging....just don't abuse it. :)
  return console if forge.is.web()

  error = (args) ->
    args = Array.prototype.slice.call(args)
    allErrors = _.filter args, (o) -> o && o instanceof Error
    if allErrors
      f = _.first allErrors

  # Forge expects only two parameters to log, message and error. We need
  # to combine them into a single string. I don't want to give up being
  # able to pass objects to console.log since that is pretty useful for
  # inspecting them.
  message = (args) ->
    # arguments isn't a _real_ array and needs to be converted to one before
    # joining it as a string.
    #
    # Todo. It would be nice to format this message a bit. It jumbles together
    # in the console.
    Array.prototype.slice.call(args).toString()

  groups = []

  group = (name) ->
    log "▾ #{name}"
    groups.push name

  groupEnd = ->
    groups.pop()

  log = (message, error, method = forge.logging.log) ->
    padding = ""
    _.times groups.length, -> padding += '| '

    forge.logging.log "#{padding}#{message}", error


  log:      -> log message(arguments), error(arguments)
  debug:    -> log message(arguments), error(arguments), forge.logging.debug
  info:     -> log message(arguments), error(arguments), forge.logging.info
  warn:     -> log message(arguments), error(arguments), forge.logging.warn
  error:    -> log message(arguments), error(arguments), forge.logging.error
  critical: -> log message(arguments), error(arguments), forge.logging.critical
  group: group
  groupCollapsed: group
  groupEnd: groupEnd

{% endhighlight %}

So you might be wondering what `group` does. Let's just say it's awesome. Try it out. It does what you think it should do in the browser
and we just recreated it a bit here. So now we can inject `logging` and call all the log methods we want.

Now to deal with the output. I create [`grunt-forge`](https://github.com/MarkBorcherding/grunt-forge) to wrap running forge in order to get
it built into our Yeoman workflow. We just needed to tweak that a bit to strip out the bits we don't care about...most of the time. After a
bit of tweaking, we end up with output that looks like this.

    Running "forge:build" (forge) task
    [   INFO] Forge tools running at version 3.3.37
    [   INFO] Update result: you already have the latest tools
    [   INFO] Checking JavaScript files...
    [WARNING] /Users/markborcherding/source/natron/HeartChase-Mobile/src/components/angular/angular.js(60): SyntaxError: int is a reserved identifier
    [WARNING]     msie              = int((/msie (\d+)/.exec(lowercase(navigator.userAgent)) || [])[1]),
    [WARNING] ........................^
    [WARNING] /Users/markborcherding/source/natron/HeartChase-Mobile/src/components/underscore/test/vendor/qunit.js(499): SyntaxError: invalid property id
    [WARNING] 	throws: function( block, expected, message ) {
    [WARNING] ........^
    [   INFO] JavaScript check complete
    [   INFO] Verifying your configuration settings...
    [   INFO] Configuration settings check complete
    [   INFO] Development build created. Use forge run to run your app.

    Running "forge:ios_sim" (forge) task
    [   INFO] Forge tools running at version 3.3.37
    [   INFO] Running iOS Simulator
    [   INFO] Starting simulator
    [   INFO] Showing log output:
    [   INFO] Loading pusher service
    [   INFO] Pusher : State changed : initialized -> connecting
    [   INFO] Pusher : Connecting
    [   INFO] Pusher : State changed : connecting -> connected
    [   INFO] Pusher : Event sent : {"event":"pusher:subscribe","data":{"channel":"zsuwjs"}}
    [   INFO] Pusher : Event sent : {"event":"pusher:subscribe","data":{"channel":"event_103"}}
    [   INFO] Showing tab,map
    [   INFO] Loading game event,[object Object]
    [   INFO] Clearing existing markers
    [   INFO] ▾ Map._drawEventMarkers
    [   INFO] | Creating HQ Marker
    [   INFO] | ▾ Drawing Challenge Markers
    [   INFO] | | Drawing challenge marker,[object Object]
    [   INFO] | | Drawing challenge marker,[object Object]
    [   INFO] | ▾ Drawing donation markers
    [   INFO] | | Drawing donation:,[object Object]
    [   INFO] | | Drawing donation:,[object Object]
    [   INFO] Showing tab,pics
    [   INFO] Moving to the next step
    [   INFO] Sharing photo
    [   INFO] Submitting team photo,zsuwjs,
    [  ERROR] Error: 'undefined' is not an object
    [  ERROR] Stack trace:
    [  ERROR] submitPhoto@file:///..../src/scripts/services.js:11
    [  ERROR] sharePhoto@file:///..../src/scripts/controllers.js:124
    [  ERROR] @file:///..../src/components/angular/angular.js:6262
    [  ERROR] $eval@file:///..../src/components/angular/angular.js:7985
    [  ERROR] f@file:///..../src/scripts/nb.js:208
    [  ERROR] @file:///..../src/scripts/nb.js:212
    [  ERROR] $eval@file:///..../src/components/angular/angular.js:7985
    [  ERROR] $apply@file:///..../src/components/angular/angular.js:8063
    [  ERROR] onTouch@file:///..../src/scripts/nb.js:211
    [  ERROR] @file:///..../src/components/angular/angular.js:1927


That is some output that is much more useful to me. You can see a bit of the groups at work there too. I'm not entirely proud of `grunt-forge` as it exists
now, but it's a good start and it makes Trigger's log so much more useful to me.
