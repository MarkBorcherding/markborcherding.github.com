---
layout: post
title: "AngularJS, CoffeeScript and Classes"
---

I've been working on an [AngularJS](http://angularjs.org/) project lately and have really come to like it. While I'm at it, I'm
giving [CoffeScript](http://coffeescript.org/) a real try (again). AngularJS has been really great so far. It feels really light
and doesn't take much to get up and running. It's still unknown if I'm doing it the _right_ way or I'm mucking it all up, but
things are working, are easy to read and test, so I really can't complain too much. I'm putting the patterns I find useful in
[MarkBorcherding/angular-seed](https://github.com/MarkBorcherding/angular-seed).

My latest challenge was to make my CoffeeScript classes available inside my AngularJS controllers. I had a class with an embdedded
class such as this:

{% highlight coffeescript %}
controller 'MyCtrl', ($scope) ->

  class Map
    constructor: (data) ->
      # setup the map

    toggle_map_type: ->
      # do whatever

  map = new Map($scope.some_data)
  $scope.toggle_map_type = ->
    map.toggle_map_type()

{% endhighlight %}

So that does exactly what I want it to do, but the presence of the `Map` class in there clutters up its essence. I would like to move that
out of the controller. I could just toss it in a top level file, maybe create a nice namespace for it, but Angular has the ability
to inject services into my controller. Why not inject this class too?

Here's where I don't know if I'm jacking it all up. I'm not sure if this should be injected as a value or a service. It makes sense to me
to be either since it is a constant...but happens to be a function. So here it goes.

I created a new factory service (using the helpers from my `angular-seed` project).

{% highlight coffeescript %}

factory 'Map', ->
  class Map
    constructor: (data) ->
      # setup the map

    toggle_map_type: ->
      # do whatever
{% endhighlight %}

Now I can just inject it on the controller.

{% highlight coffeescript %}
controller 'MyCtrl', ($scope, Map) ->

  map = new Map($scope.some_data)
  $scope.toggle_map_type = ->
    map.toggle_map_type()
{% endhighlight %}

Done. Is that actually a service? I don't want the constructor function invoked when it injects, so that's why I ended up making it a
factory rather than a service. Right now it's working, and when testing the controller that class is easy to mock so I'm happy so far.


