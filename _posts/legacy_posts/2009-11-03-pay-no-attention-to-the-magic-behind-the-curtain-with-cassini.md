---
title: Pay no attention to the magic behind the curtain with Cassini
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p><a href="http://www.flickr.com/photos/senorpep/2624206022/"><img style="margin: 0px 5px 0px 0px; display: inline" align="left" src="http://farm4.static.flickr.com/3271/2624206022_c0cd5b0783_m.jpg" /></a> Cassini can be very misleading. For example, spin up web site that uses routing in Cassini and it works without a problem. Do you have to add the routing module or handler? Nope. It just works. Its so nice and helpful, but that really gives you a false sense of security. </p>  <p>IIS is not so nice. We recently ran into this where things worked great in Cassini, but as soon as they were deployed to IIS, nothing routed. It turns out we were missing a bit in the web.config that enabled routing. </p>  <p>I just stole that section from a newly created MVC 2.0 applications web.config. </p>
