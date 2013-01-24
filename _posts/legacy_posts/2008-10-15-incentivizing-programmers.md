---
title: Incentivizing Programmers
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<img class="alignright size-full wp-image-430" title="brokenbuilds001" src="/wp-content/uploads/2008/10/brokenbuilds001.png" alt="" width="400" height="239" />In most factories, especially those that pride themselves on their safety records, you'll find a sign that says something like "600 days since our last lost time incident". We should have the same for our automated build qualities, although I doubt they will ever reach 600 days of consecutive green builds. It would hopefully generate a sense of pride in the build. Imagine if you joined a team that had 60 days of green builds and that number was publicized for the entire organization to see. Wouldn't you take extra care to make sure you don't do something that flips it over to red, even for one build?

Gaining momentum behind doing automated build is something our organization is struggling with at the moment. For some reason the value isn't immediately apparent or the schedules and budgets don't allow for it at the moment. Both of those are topics for another post. Maybe a component to gaining that momentum is illustrating the elevation and longevity of the quality of the builds. I see two metrics being valuable.
<ol>
	<li>Days of consecutive green builds</li>
	<li>Change in the number of unit tests over time</li>
</ol>
<em>Potentially a third being the number of customer reported defects.</em>

The number of consecutive green builds is important, but if one team is doing nightly builds and another is doing continuous integration, does one team have a significant advantage in quality over another? I would say there is benefit there, but I wouldn't categorize the advantage as significant. Also, looking at the change in the number of tests provides a better indication of progress than percentage change. Adding a hundred unit tests to a build that already has a thousand is substantially better than adding one unit test to a set of ten. I imagine you're saying that is still rather subjective because you could have ten quality tests and a thousand horribly simple ones and that's true, but maybe this isn't the place to make those determinations. Let's assume all unit tests are of roughly the same complexity and comprehension.

So here is my question. <strong>Would it be valid and beneficial to incentivize teams to improve these metrics or compete against other teams to improve the metrics?</strong> In the past we've given out $5 gift cards to Starbucks or iTunes when people did good jobs on something, just as a nice "thank you". Would that work here? Could giving a $5 gift card to the each member of the team that has the longest stretch of green builds or added the most unit tests in the last month help motivate people? Now I don't expect people to add hundreds unit tests every month to get their free <em>fat free half caf soy carmel white chocolate mocha macchiato</em> (I'm not even sure that drink exists or if would be less than $5 if it did). I'm not saying those are the metrics and the periodicity of the rewards that would work the best, just wondering if the spirit of it would work.

Recent posts by <a title="Sins of Omissions" href="http://ayende.com/Blog/archive/2008/10/11/sins-of-omissions.aspx">Ayende</a> and <a title="How Hard Could It Be?: Sins of Commissions, Marketing and Advertising Article - Inc. Article" href="http://www.inc.com/magazine/20081001/how-hard-could-it-be-sins-of-commissions.html?partner=fogcreek">Joel Spolsky</a> seem to imply it would fail miserably.

I'm not sure something like $5 will lead teams to work the system just for the reward. Even without the monetary reward <strong>the principle behind taking pride in the build quality could established by making an aggregated build report public</strong>. Something <em>really</em> public. Maybe a screen when I get off the elevators, or a TV in the lobby that gives some metrics. Let me see who the people are who are writing the most unit test. I'm sure they can answer some of my questions or give me advice. Show me who isn't building and we can get them the help they need to get it off the ground. There should be something we could do to help.
