---
title: Visual Studio 2010 Cassini IIS Deltas
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Weve recently upgraded to the shiny new Visual Studio 2010 Beta 2. With the go live license we hope we can transition to the RTM once it drops. It has some nice features everyone already knows about.</p>  <p>First step to the future, the conversion. The conversion went pretty smooth. It doesnt like the MVC 1.0 project, but thats OK since it was just a shell placeholder. We plan on converting that to the MVC 2.0 before we get any real work in there.</p>  <p>After fixing a few minor things the conversion wizard missed, we fire up the app in Cassini.and it looks awful.<img style="border-bottom: 0px; border-left: 0px; margin: 0px auto; display: block; float: none; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/10/image_thumb.png" width="256" height="332" /></p>  <p></p>  <p>OK, well maybe it doesnt look awful, but it doesnt look how our talented designers want it to look. It is mostly there. That bottom block should appear to the right of the login. Fire up the same VS 2010 project in IIS and it looks fine. <img style="border-bottom: 0px; border-left: 0px; display: block; float: none; margin-left: auto; border-top: 0px; margin-right: auto; border-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/10/image_thumb1.png" width="640" height="281" /></p>  <p>Weird huh? Looking at the HTML there are a few differences between the two, but none that we would really expect to cause the two to render differently. Some URLs were changed to absolute URLs and include the hostname and port of each site. There are some view state differences, but nothing else.&#160; HmmWhy dont we just stop using Cassini and debug through IIS.</p>  <p>There were just a few steps needed to set that up. First, tell Visual Studio to use a different server besides the development server. </p>  <p><a href="/wp-content/uploads/2009/10/image.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/10/image_thumb2.png" width="640" height="341" /></a> </p>  <p>Here weve already setup a host header IIS site and added dev.mysite.localhost do the hosts file. We have a hybrid of ASP.Net and classic ASP, so we already used ISS for a lot of testing. </p>  <p>Second step, run Visual Studio as administrator. You can default the shortcut to always run as administrator by editing the advanced properties of the shortcut. </p>  <p><a href="/wp-content/uploads/2009/10/image1.png"><img style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/10/image_thumb3.png" width="394" height="300" /></a> </p>  <p>Thats it. It looks like Visual Studio automatically attaches to the IIS process. The best part; <strong>It is a worlds faster than Cassini</strong>. I dont know why you would debug through Cassini, unless you had to because you were missing either administrator privileges or missing IIS with your Home version of Windows. </p>