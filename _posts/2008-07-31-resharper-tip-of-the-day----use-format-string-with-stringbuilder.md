---
title: ReSharper Tip of the Day -- Use Format string with StringBuilder
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Some classes like StringBuilder build in the string.Format functionality. ReSharper knows this and helps you out. Itll recognize you should probably be using a format string.
 <img src="/wp-content/uploads/2008/07/formatstring-trans.png" alt="" title="formatstring-trans" width="437" height="107" class="alignnone size-full wp-image-161" />

and then turn it into the right method.
<img src="/wp-content/uploads/2008/07/appendformat-trans.png" alt="" title="appendformat-trans" width="365" height="77" class="alignnone size-full wp-image-162" />
