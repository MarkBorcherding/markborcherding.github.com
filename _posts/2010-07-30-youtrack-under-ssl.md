---
title: YouTrack under SSL
layout: post
description: "Something really cool"
category:
tags: [ ]
---



<p>I have to admit, this post is going to be lame. I wont be offended if you stop reading now because it is mostly for my own benefit.</p>  <p>Recently we moved our YouTrack server to a publicly accessible server and got it all setup with an URL like <a href="http://dev.acme.com">http://dev.acme.com</a>. We then wanted to move out TeamCity server to the same box so moved both TeamCity and YouTrack into a Tomcat app server and gave them URLs like dev.acme.com/teamCity and dev.acme.com/youTrack. Sweet. Everything is going great.&#160; We have them talking to each other. </p>  <p>Lets flip them over to talk on only SSL. This wasnt was easy as I hoped. Actually it was super simple, but finding the steps was painful. If you look for how to setup SSL with Tomcat you find a load of articles using tools and certificates we dont have handy. We do have our wild card certificate from IIS that we can export and then <a href="http://tp.its.yale.edu/pipermail/cas/2005-July/001337.html">the steps are easy</a>. </p>  <p>Sweet. While I was in that file I commented out the Tomcat connector on port 80 so IIS could listen on that port. Im more familiar with IIS and setting up the HTTP to HTTPS redirect was easier for me in IISwhich I did next. </p>  <p>All done. Everything is golden right? It works. It redirects to HTTPS if you request HTTP. Awesomeexcept we cannot attach files. Bummer.</p>  <p>We get asked questions like:</p>  <blockquote>   <p>Are you using a proxy?     <br />Please specifiy procy if you are using one, otherwise it is impossible to post the attachment.</p> </blockquote>  <p>Since we are not using a proxy I said no and then got another error message.</p>  <blockquote>   <p>Sorry, cannot attach the image.</p> </blockquote>  <p>Luckily this was an <a href="http://youtrack.jetbrains.net/issue/JT-3522?projectKey=JT&amp;query=proxy">easy fix</a> as well. This was a fairly easy issue to find since JetBrains publicly tracks the issues with YouTrack. That was exactly out problem. We had YouTrack setup to listen on <a href="http://dev.acme.com/youTrack">http://dev.acme.com/youTrack</a> instead of <a href="https://dev.acme.com/youTrack">https://dev.acme.com/youTrack</a>. Switching that in the settings fixed our problem. </p>