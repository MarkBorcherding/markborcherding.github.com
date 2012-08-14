---
title: Xcode one ups #region in Visual Studio
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>I hate regions in Visual Studio. I dont like the fact you can hide code from my incremental search and scanning eyes. If it is unimportant to me at the moment, give me a mechanism to jump over it.</p>  <pre language="c#" name="code">#region &quot;collapse me&quot;
    // youll never see me if Im collapsed.
#endregion</pre>

<p>I dont like that I cant CTRL+I through them nor CTRL+F will skip them unless you tell them otherwise. </p>

<p>While Visual Studio gives your the ability to skip to the method directly via a dropdown.</p>

<p><a href="/wp-content/uploads/2009/06/image5.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/06/image_thumb.png" width="308" height="224" /></a></p>

<p>The dropdown is nice and all, but the members are in alphabetical order, not the order they are in file. Alphabetical may make sense in some cases, but I usually have related members near each other in the source. When I go look for them in the dropdown, why arent they the same.</p>

<p>Xcode does things a bit differently. They line up everything with the order of the members in the file. Also, they let you give clues to the IDE to format the dropdown into sections. Brilliant. </p>

<p><a href="/wp-content/uploads/2009/06/image6.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/06/image_thumb1.png" width="633" height="494" /></a> </p>

<p>Notice the following lines of source and their related markup of the dropdown.</p>

<pre language="c" name="code">#pragma mark -
#pragma mark Picker DataSource Methods</pre>

<p>Pretty awesome huh? The best part is as you move the code around, the markup and members move in the dropdown. A+</p>
