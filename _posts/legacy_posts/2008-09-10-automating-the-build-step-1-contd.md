---
title: Automating the Build (Step 1 cont'd)
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



After the disappointing ending to <a href="/2008/09/05/automating-the-build-step-1/">my previous post</a>, I now have much success to report. Once we had the correct path to the MSTest.exe on the build server, I was able to publish the results of my NUnit tests. There are a few things to note.
<ol>
	<li>You still need MSTest.exe on the build server. I guess that is OK since we, at our organization, want to allow for the ability to run MSTests as well. I'm not 100% sure that happens on the build server or the TFS server.</li>
	<li>As of now, if the NUnit tests fail, it will not run the MSTest. This is because we are executing the NUnit tests in the AfterCompile target as suggested in the<a href="http://www.codeplex.com/nunit4teambuild"> NUnit for Team Build</a> example. I'm not really sure why you would do both in the same solution, but if you do, you won't see failures from both. Only one at a time. I'm looking into getting both to run, but that isn't going to be much of a priority since we won't need to run both in the same solution.</li>
</ol>
I am really excited that we have this running with such little effort. Thanks has to go to the NUnit for Team Build guys.

One to step two when time allows.
