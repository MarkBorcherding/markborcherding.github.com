---
title: Objective C Syntax. Black goats make the best sweaters.
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p style="text-align: left; "><a href="http://en.wikipedia.org/wiki/Cashmere_wool"><img class="alignright" title="Black Goat" src="http://upload.wikimedia.org/wikipedia/commons/7/7b/Pashmina_goats.jpg" alt="" width="448" height="419" /></a>I've been dabbling with Objective C with dreams of making the next great iPhone app. It is slow starting out. Objective C looks pretty Greek to me, even though I do have some C experience. It's heavy with the symbol tax and is much lower level than C# or Java; no memory management, header files, pointer declarations. It's painful, but I'm really starting to like it. It's almost sick to like it, but there are a few features of the language that are really nice and however impossible, I would like to see them appear in the C# spec.</p>

One feature that has been key in learning the language are the named parameters. Unlike C#, who is getting named parameters, in Objective C they are not optional. You <em>have</em> to include them otherwise it doesn't know which method to call.

Before we look at an example, I want to stress <strong>I am not trained in Objective C</strong>, at all. This is only what I've collected from the few examples and code I've sifted through. Don't repeat any of this to anyone, except to mock my ignorance if you do discover it. Verbatim regurgitation of this might embarrass yourself. I'm used to it, so I don't mind.

On to an example.
<pre class="c" name="code">	
[NSTimer scheduledTimerWithTimeInterval: 1.0 
                                 target:self 
                               selector:@selector(onFired:) 
                               userInfo:nil 
                                repeats:YES];
</pre>
So in this line of code we make a static call to the type NSTimer. (As a side note, a lot of the core Cocoa classes are prefixed with "NS" as Cocoa is a derivation of NeXTSTEP.). Here we pass five arguments to a method, all obviously named. Compare this to comparable code in C#.
<pre class="c#" name="code">	NSTimer.scheduledTimerWithTimeInterval(1.0,this,onFired,null,true);</pre>
It's obvious to me what the first one is doing with all of its arguments, but in C#, you have no idea. Take a more obvious example, but completely contrived example.
<pre class="c#" name="code">	setLabelStyle(blue,black,10,1,true,false,1.0);</pre>
What does that function do? Who knows right. It sets something blue, something black, something to 10, etc. The details of it are obscure. Now look at it in Objective C.
<pre class="c" name="code">	[self setLabelColor:blue
	         background:black
	           fontSize:10
	        fontSpacing:1
	               bold:true
	            italics:false
	            opacity:1.0 ];</pre>
I changed the name of the method only to more closely follow how it would be named in Objective C. The style tends to run the method name into describing the first parameter, since that parameter doesn't get  its own name. You can see how much more explicit that is than in C#. It could be said it is a less dry because you have to repeat those names each time you invoke the method, but its clarity is worth the cost to me.

At first I wondered if since they were named, does that mean they are all optional and order is not important. Wrong! You have to list them and they have to be in that order. Take the same example in .Net 4.0 using named properties.
<pre class="C#" name="code">	setLabelStyle(Color:blue, bold:true, fontSize:10)</pre>
We can default the rest instead of overloading the method a bunch of times. Once we get into named properties, I might consider trying to enforce we always use them, especially when calling non-private methods. That might be a hard sell, but I really like them.

So the post was going to be subtitled "Black sheep make the best sweaters.", but cashmere comes from goats and not sheep.
