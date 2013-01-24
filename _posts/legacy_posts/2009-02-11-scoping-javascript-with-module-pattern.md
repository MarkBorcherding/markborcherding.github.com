---
title: Scoping JavaScript with Module Pattern
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<a href="http://flickr.com/photos/darwinbell/538421096/in/set-72157594189670735"><img class="alignleft" title="Padlock" src="http://farm2.static.flickr.com/1010/538421096_5b98da6805_m.jpg" alt="" width="169" height="240" /></a>I've entered the world of actually writing JavaScript. In the past, usability was really a secondary concern. I need to do a postback to make a button visible, no problem. The screen will flash, but who cares. It's not like the user is going to stop using my application to do the stack of work on their desk. They have to use it. It's their only option.

Now that isn't entirely true. We attempted to make it as usable as possible, but anything that even close to using jQuery was probably just, according to the powers that be, the developers just playing around with cool toys. I'm not sure the value of the user experience fell nicely into a quantifiable metric. I'm beginning to rant, so back to the point.

In my new adventures with jQuery, I've been writing a lot of JavaScript. The biggest complaint I've had with my JavaScript is that everything is global and can potentially be overwritten by subsequent JavaScript, or I might be overwriting someone else's functions or variables. My JavaScript files looked like the following.
<pre language="javascript" name="code">
var foo = "berry";
function doWork(s){
	alert(s+foo);
}

$(function(){doWork("foo")});
</pre>

I just cross my fingers that no one else has a <code>doWork</code> function or <code>foo</code> variable. There has to be a way to scope this stuff. 

Luckily, I found and article that explains exactly that. <a href="http://www.wait-till-i.com/2007/07/24/show-love-to-the-module-pattern/" title="Wait till I come!  &raquo; Blog Archive   &raquo; Show love to the Module Pattern">It explains the Module Pattern</a> and how to use it to limit the scope of JavaScript.

I'll let you read the article for a more complete description that I could put together, but ultimately, my JavaScript ends up looking like this. 
<pre language="javascript" name="code">
myScript = function(){
  return {
	init:function(){doWork("foo");}
  }
  var foo = "berry";
  function doWork(s){  
	alert(s+foo);
  }
}();
$(myScript.init);
</pre>
In this case, <code>init</code> is the only method that gets exposed. You can't invoke <code>doWork</code>. Also, by adding the scope of <code>myScript</code>, you can have greater confidence your methods and variables aren't getting overwritten.

My practice thus far is to have one JavaScript file for each page and user control. The scope of each page's file is the name of the page, or control. So you could see <code>Login.aspx.js</code> with a scope of <code>MyApp_Login</code>.

So far so good. We'll see how it goes.
