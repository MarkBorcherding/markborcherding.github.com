---
title: Finding parent elements with jQuery 1.3
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<a title="magnifying monkey man. by ohhector, on Flickr" href="http://www.flickr.com/photos/ohhector/508933636/">
<img class="alignright" src="http://farm1.static.flickr.com/211/508933636_0ab1a791bb_m.jpg" alt="magnifying monkey man." width="240" height="160" /></a>

I was recently writing a little javascript function that would traverse up the object graph and apply jQuery selectors to pick the correct parent that I needed. It was a pretty basic function, but I had that gut feeling that this is something that I shouldn't be writing. It <em>has</em>to be already written by someome.

Luckily, with jQuery 1.3, it's part of the core library. New in this version is the <code><a href="http://docs.jquery.com/Traversing/closest">closest</a></code> method which will find the closest parent that matches the selector you pass.
