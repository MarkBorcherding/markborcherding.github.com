---
title: ReSharper Tip of the Day -- Peek at opening brace
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



It has been far to long since the last R#TOTD, so to ease back in, I thought wed take it slow with this one.

If youre unfortunate enough to have your methods grow beyond what can fit on a screen, or just happen to have the method scrolled off the top of the screen, you can identify those closing braces with ease. When ReSharper goes to match the opening brace for the current closing brace at the cursor,a pop up with a tooltip appears if that brace happens to be out of view. It is very handy in finding closing namespace and class braces.

<a href="/wp-content/uploads/2009/04/image.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" src="/wp-content/uploads/2009/04/image-thumb.png" border="0" alt="image" width="700" height="374" /></a>

It gets even better in <a href="http://www.jetbrains.com/ruby/index.html">RubyMine</a> with syntax highlighting and a semi-permanent window (i.e. it will stay visible while you scroll). Even though Im not a Ruby developer by trade, I still use RubyMine for editing all my JavaScript files. The intellisense is great and <strong>you get ReSharper-like context refactorings in JavaScript files</strong>.

<a href="/wp-content/uploads/2009/04/image1.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" src="/wp-content/uploads/2009/04/image-thumb1.png" border="0" alt="image" width="598" height="185" /></a>
