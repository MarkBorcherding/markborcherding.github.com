---
title: Google Frame to save the day
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p><a href="http://www.flickr.com/photos/balakov/2954431151/"><img style="border-right-width: 0px; margin: 0px 0px 0px 15px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="madmen_icon" border="0" alt="madmen_icon" align="right" src="http://farm4.static.flickr.com/3295/2954431151_c1f44b1315.jpg" width="356" height="500" /></a></p>  <p>When they announced <a href="http://code.google.com/chrome/chromeframe/">Google Frame</a> I was really puzzled. Why? Who would actually <em>want</em> to use IE so badly they would install this? Why not just use the super sexy Chrome and all its goodness? </p>  <p>It finally hit me when today we found a rendering discrepancy on our intranet between IE and the rest of the universe. Ugh! Were going to hack this thing to get it to work for the three people that want to use IE. </p>  <p>Wait. There is a masked superhero that will save the day. Google Frame! </p>  <p>I have to add one line to my page:</p>  <pre>&lt;meta http-equiv=&quot;X-UA-Compatible&quot;
         content=&quot;chrome=1&quot;&gt;</pre>

<p>install the plug-in and Im done! It looks beautiful. The best part is no more sludge and crime in our CSS. Google Frame can clean it all up and prevent any future offenses. </p>
