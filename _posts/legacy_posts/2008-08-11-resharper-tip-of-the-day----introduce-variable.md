---
title: ReSharper Tip of the Day -- Introduce Variable
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I recently wrote a post about how <a href="/2008/08/08/resharper-wish-list-replace-literal-with/">I wish I could</a> have a context action to replace a string literal with a new constant. To my surprise, someone from JetBrains posted a comment saying it would already do it.

It isn't as discoverable as other context actions, but it does work. With your cursor in the string you want to replace, you can press <em>Ctrl+W</em> to extend the selection to the entire string. This is important. Without selecting the string, it will try to introduce a variable for the entire statement. With the string selected, press <em>Ctrl+R,V</em> to introduce a variable. It will notice it can replace all the occurrences of the selected string.

<img class="alignnone size-full wp-image-213" title="replacefoo" src="/wp-content/uploads/2008/08/replacefoo.jpg" alt="" />

Select that you want to replace all the occurrences, and press Enter. There is the constant that I wanted to introduce.

<img class="alignnone size-full wp-image-214" title="replacefoowithconstant" src="/wp-content/uploads/2008/08/replacefoowithconstant.jpg" alt=""  />

It gives you some suggested variable names too.

<img class="alignnone size-full wp-image-215" title="selectvariablename" src="/wp-content/uploads/2008/08/selectvariablename.jpg" alt=""  />

Additionally, you can use <code>Ctrl+R,F</code> to introduce a field if you want the replacement at a higher level.

Thanks JetBrains! That would be a cooler context action though.
