---
title: Firebug is great, but...
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<a href="http://getfirebug.com/" title="Firebug - Web Development Evolved">Firebug</a> is the single most important piece of software I use when developing the layout of a web UI. For the longest time at my previous employer, installing Firebug and Firefox would also, after the evening big brother scan, install a nice e-mail in your inbox from the compliance nazis about your recent contraband software installation, and strongly suggest you rethink your decision. Recently however, they have seen the light and no longer send out that nasty little e-mail. But on to my only gripe about Firebug.

Let's take this simple page and bring up Firebug.

<img src="/wp-content/uploads/2009/01/firebugoriginal.png" alt="Firebug.Original" height="488" width="559">

Now, we can click into the style we want to change and use the up and down arrow keys to modify the numeric value. This is an awesome feature to position elements with paddings and margins. Imagine doing this with several elements via their class's associated style and seeing the effect on the entire page. Pretty awesome!

<img src="/wp-content/uploads/2009/01/firebugmodified.png" alt="Firebug.Modified" height="488" width="559">

We can switch over to the CSS view and see our change.

<img src="/wp-content/uploads/2009/01/firebugcssview.png" alt="Firebug.CssView" height="358" width="535">

Great! Now let's find a ways to pull out all those changes so we can paste them back into our real CSS file.
<img src="/wp-content/uploads/2009/01/firebugcsswithoutchanges.png" alt="Firebug.CssWithoutChanges" height="358" width="535">

Where are my changes? I realize it might not be able to recreate that CSS file from my changes because of elements Firebug couldn't handle, but how can I get <em>all</em> my changes out at once? Even if I am viewing a local file, like I am in this case, there appears to be no way to export my modifications form Firebug in one bulk export.
