---
title: jQuery Validation and ASP.Net Web Forms
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I've been dark for a while, but there has been a lot in the works. Hopefully there will be a flood of posts coming, most with a happier outcome than this one; however, to get back in the swing of things, I'll take make it short and sweet.

<strong>I get really frustrated with ASP.Net Web Forms</strong>

We all know and love jQuery. It is an amazing JavaScript framework. It's made it possible, for even the staunchest back-end developers, to get excited about writing UI. ASP.Net is the bane of jQuery enjoyment. I've covered this in <a title="www.fooberry.com  jQuery Selectors and ASP.Net Controls" href="/2009/01/07/jquery-selectors-and-aspnet-controls/">jQuery Selectors and ASP.Net Controls</a>. I have a new frustration: the giant HTML Form ASP.Net puts in the Web Form page.

There is an amazing jQuery <a title="bassistance.de  jQuery plugin: Validation" href="http://bassistance.de/jquery-plugins/jquery-plugin-validation/">validation plugin</a>. It can do just about any validation you'll need with minimal effort. If you want to validate a single form, it's great; however, if you need to validate only a portion of the form, it's a pain.

Since ASP.Net sticks its own <code>&lt;form&gt;</code>tag on the page by default, you're pretty much screwed. The only option I've found so far is to go through each element, running a validation on the individual elements.

Here is an example of what I'm doing:
<pre class="javascript">$().ready(function(){

	$("form").validate();	

	$("#firstname").rules("add", {
	 	minlength: 2,
		required:  true
	});

	$("#submit").click(function(){
		var valid = true;
		valid = valid &amp;&amp; $("form").validate().element("#firstname");
		alert(valid);
   	});
});</pre>
I hope to find a better solution soon, but this will do for now.
