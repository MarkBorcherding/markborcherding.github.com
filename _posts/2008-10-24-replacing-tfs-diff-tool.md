---
title: Replacing TFS Diff Tool
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



The TFS diff tool is horrible. It a pretty bare minimum difference between the two versions. The UI is basic.

<a href="/wp-content/uploads/2008/10/image.png"><img title="image" src="/wp-content/uploads/2008/10/image-thumb.png" border="0" alt="image" width="680" /></a>

Nice huh? This line changed, but youre on your own to know what characters actually changed. While tooling around in the Visual Studio Options dialog I can across the settings that would let me change the diff and merge tools.Check out <em>Tools | Options | Source Control | Visual Studio Team Foundation | Configure User Tools</em>

<a href="/wp-content/uploads/2008/10/image1.png"><img title="image" src="/wp-content/uploads/2008/10/image-thumb1.png" border="0" alt="image" width="402" height="240" /></a>

I needed a another diff tool, so I downloaded a trial of Beyond Compare and plugged it in there and it worked great! Except, in 15 days it wouldnt be working so great unless I could convince someone to shell out the $X to get us past the trial. After pinging some of my buddies about what diff tools they use, I decided to try the diff tool in <a href="http://tortoisesvn.tigris.org/">TortoiseSVN</a>. I installed it and added <a href="http://tortoisesvn.tigris.org/TortoiseMerge.html">TortoiseMerge</a> to the dialog.

<a href="/wp-content/uploads/2008/10/image2.png"><img title="image" src="/wp-content/uploads/2008/10/image-thumb2.png" border="0" alt="image" width="356" height="187" /></a>

Ran my compare again and <a href="http://en.wikipedia.org/wiki/Emeril_Lagasse">Bang</a>! A new diff dialog appears that is much better than before.

<a href="/wp-content/uploads/2008/10/image3.png"><img title="image" src="/wp-content/uploads/2008/10/image-thumb3.png" border="0" alt="image" width="680" /></a>

That is still a lot of redundant clutter for me, so switching views helps a little with that.

<a href="/wp-content/uploads/2008/10/image4.png"><img style="border-top-width: 0px; display: inline; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" title="image" src="/wp-content/uploads/2008/10/image-thumb4.png" border="0" alt="image" width="554" height="280" /></a>

We no longer get the detail about what changed on a line, but it is so much easier to manually identify when the rows overlap, Im not missing it.
