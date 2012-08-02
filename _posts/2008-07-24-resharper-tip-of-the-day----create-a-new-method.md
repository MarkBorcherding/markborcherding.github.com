---
title: ReSharper Tip of the Day -- Create a New Method
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I needed to create a list of categories in my class that I want to populate using my facade. So instead of going to the facade and creating it there, let's just do it right here where I need it. It'll help get the signature right, granted this one is pretty simple. I type how I want to use it and press my handy dandy <em>Alt+Enter</em>.

<img class="alignnone size-full wp-image-89" title="createmethod" src="/wp-content/uploads/2008/07/createmethod.jpg" alt="" />

Why yes Resharper, I would like to create a method with that exact name on that exact class. Thank you. It generates the stub for the method in the right class.

<img class="alignnone size-full wp-image-88" title="newmethod" src="/wp-content/uploads/2008/07/newmethod.jpg" alt="" />

Here is where I start my unit testing.

Granted this method was really simple, but if you had two or three parameters it becomes much more valuable.
