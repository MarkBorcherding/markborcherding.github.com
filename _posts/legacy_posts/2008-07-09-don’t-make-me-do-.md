---
title: Dont Make Me Do 
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I recently marked over 130 tests with <span style="font-family: Lucida Console; color: #000080;">[<span style="color: #008080;">Ignore</span>]</span> in order to get our build to go return to green. It made me cringe to do it, but we lost our local database instance several months ago and many of the tests required it. That was a good 70% of them. The other 30% purely fell victim to apathy. When our local database instance was pulled, so was our build server, as well as other tools (a whole other post:S).

So since the build server stopped waving our failing tests in our face, about 40 test went on failing for months. Out of the entire test suite of 600, the 40 tests are only 7%, but hat 7% was mostly heavy financial calculation. An important 7% of our app.

This whole experience reminded me how lazy we are as a whole, but thats OK. We have tooling (if we use it) to allow us to stay lazy. Maybe <em>lazy</em> has too negative of a connotation. How about <em>focused</em>. It reminds me of <a href="http://www.amazon.com/Common-Approach-Usability-Circle-Com-Library/dp/0789723107" target="_blank">Dont Make Me Think!</a>. Except with developers, its Dont Make Me <em>Do</em>. I dont want to run my <em>all </em>my unit tests, analyze my code, increment my version numbers, or anything else not related to my business customer. If infrastructure is plumbing we abstract away from the application, so is the process. I want to increment my version number as much as I want to write a database logger.
