---
title: St Louis Day of .Net Day 1 Overview
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Following acronymitis, today's post, in addition to being subtitled <em>The Return from Hiatus</em>, will be so called <em>SLDODNDOO</em>. It's been a while since my last post, but I have been hard at work, and will soon have plenty of new and exciting jQuery adventures to detail. For now, I thought I would get back in the swing of things by covering today's events at <a href="http://www.stlouisdayofdotnet.com/" title="St. Louis Day of .NET">St Louis Day of .Net</a>. I was able to attend last year's STLDODN while on a few days break between jobs and I am lucky enough to be attending this year's event, packed with 100% more excitement (two days instead of one).

<h2>The Venue</h2>
This year the event has, what looks like to me, to be twice the number of attendees and the venue is a twice as nice. <a href="http://www.ameristar.com/St_Charles_Meetings.aspx" title="Ameristar Casinos - St. Charles - Meetings and Weddings - Meetings">The Ameristar Casino and Conference Center</a> is a great venue for a conference. Walking into a Casino at 6:30 AM on a weekday does feel a bit odd, but the facilities are beautiful, spacious and impeccably clean. Registration lines looked intimidating long at first, but they moved incredibly fast and I was through in no time. 

Breakfast was delicious. I ended up showing up a bit late and there were still plenty of pastries left. There was plenty of coffee, soft drinks and water. The porcelain cups and plates highlight the elegance of the venue.

<h2>Session 0: The Jump Start Sessions</h2>
The first set of sessions in all tracks were <em>Jump Start</em> sessions meant to provide a brief, bird's eye overview of a topic in each track. I am always a little skeptical of such sessions. I'm afraid they will either be full of malicious use of flashy technologies or nothing more than what I could read in a blog post. It was probably a mistake on my part, but I chose a topic I know pretty well, in hopes of getting a new angle on my problems or validation in what I was doing. If I had been more outgoing, I could have offered additional insight to the problems others in the session voiced, but not being so, I sat, gaining little, offering even less.

Being all the sessions at that time, across all tracks, were probably similar in content depth, I would have been better spent in a session I knew little to nothing about, or were willing to offer more in those where I have a well-established understanding. 

Maybe instead of starting the day with sessions easy on the brain, letting everyone ease into the day, starting off with a keynote, with everyone in the same room, might fire up excitement and get people ready to absorb all the information they can the rest of the two days. The intro sessions could be moved to lunch where we could be enlightened while we eat.

Another option, for both the opening session of the day and lunch, would be to intentionally presenting topics from outside people's comfort zone, but do so in small 15 minute slices. Sessions like showing SVN, Git, Ruby, Rails, IronPython, IronRuby, etc. would , while not directly relating to most people's daily lives, offer some breadth to their understanding about what what else is going on in the world. I have a list of session I would like to see, and/or possibly contribute to in the future.

<h2>Session 1: <a href="http://www.stlouisdayofdotnet.com/SessionDetail.aspx?SessionID=8" title="St. Louis Day of .NET - Session Detail">Agile Iteration 0</a> 
by <a href="http://kensipe.blogspot.com/" title="Ken's Thoughts">Ken Sipe</a></h2>
At my current employer we are struggling to implement an Agile process. We recognize the need for it as the business grows, but are having a hard time breaking tradition. Ken did an amazing job with not only the quality of his content, but the engaging and entertaining presentation. I suppose it is only natural that the process coach would be extroverted and outgoing. He identified the pain points we're currently feeling and why each of the facets of an agile methodology are important. For example, he discussed why velocity is not only important for providing solid estimates, but to correlate with bug rates, and probably test coverage, to determine when teams are moving to hastily.

<h2>Session 2: <a href="http://www.stlouisdayofdotnet.com/SessionDetail.aspx?SessionID=21" title="St. Louis Day of .NET - Session Detail">Easing into Unit Testing with Mock Objects</a> 
by <a href="http://www.timbarcz.com/blog/" title="Tim Barcz">Tim Barcz</a></h2>
This session really hit home and not only validated the efforts I'm making at my current employer, but also the code I left at my previous one. While I've heard we were creating useless levels of abstraction, <em>just</em> for testing purposes. I am reassured I am not alone in believing in their concept and their importance. We were creating the same abstractions on top of those pesky static calls and are currently organizing tests in a similar fashion.

Tim prefers to separate the responsibilities of each test in a different regions of each test.

<pre name="code" class="C#">
	[Test] public void Each_test_should_describe_what_it_does(){
		// Arrange
		
		// Action
		
		// Assert
	}
</pre>

We are essentially doing the same thing.

<pre name="code" class="C#">
[TestFixture]
public class When_a_specific_action_happens : Specification{
	override public void Context(){
		// Arrange
	}
	
	override public void Behavior(){
		//Action
	}
	
	[Test] public void the_specific_action_should_be_tested(){
		// Assert
	}
}
</pre>

I actually like our method better as it provides an English readable specification of the code and its current capabilities in the build report. We're on the same page though and it's good to hear that from an MVP. <a href="http://www.andrewmilsark.com/blog/" title="AndrewMilsark.com | SharePoint mixed with .Net Development Goodness">A coworker</a> of mine shared my enthusiasm as just this week we were attempting to unit test code that has external dependencies that are difficult to mock.

<h2>Lunch</h2>
Lunch was your typical boxed lunches. The cookies were good. The oranges were a bit awkward to eat and not make a mess or smell like orange for the rest of the day. Lunch was also pretty long (1 hour 15 minutes). Thirty minutes would have been plenty, but I'm sure some found time to make a few throws at the craps table. We <em>are</em> at a casino after all.

<h2>Session 3: .NET 4.0 
by <a href="http://geekswithblogs.net/NewThingsILearned/Default.aspx" title="New Things I Learned">Muljadi Budiman</a></h2>
I saw Muljadi at last year's DODN speaking about pLinq and was really impressed. His talk on what's new in .Net 4.0 was no disappointment, although I would have rather attended his C# 4.0 talk, as it would more directly affect me. Visual Studio 2010 looks nice, but I see little improvement over what ReSharper already does, outside of the ability to pop out source to a separate monitor. There are plenty of enhancements to its support for WPF, multi-threading, etc. ,but these are all spaces that I don't dabble in on a daily basis. Muljadi is a great presenter and I would be sure to attend any session next to his name.

<h2>Session 4: User Experience != User Interface 
by <a href="http://bradsramblings.com/blog/" title="Brad&#8217;s Ramblings">Brad Nunnally</a></h2>Brad has obviously read <a href="http://www.amazon.com/Presentation-Zen-Simple-Design-Delivery/dp/0321525655" title="Amazon.com: Presentation Zen: Simple Ideas on Presentation Design and Delivery (9780321525659): Garr Reynolds: Books">Presentation Zen</a>, or seen enough presentations by those whom have. It was nice not having to see <a href="http://www.amazon.com/Cognitive-Style-Power-Point/dp/0961392150" title="Amazon.com: The Cognitive Style of Power Point (9780961392154): Edward R. Tufte: Books">bullet point after bullet point</a>, and actually listen to what he had to say.  I<em> do</em> think the title of the presentation would better serve the audience if it described, what I felt, was the theme of the presentationL <em>Why should you care about UX?</em>, or: <em>The role of a UX Engineer</em>. The topic, maybe only to me, was ambiguous, although the material was well-prepared and direct. I have to admit, I found the animation between the slides distracting and unnecessary. They disrupted the cadence of the presentation as we all waited for them to transition.

<div style="width:425px;text-align:left" id="__ss_1934382"><a style="font:14px Helvetica,Arial,Sans-serif;display:block;margin:12px 0 3px 0;text-decoration:underline;" href="http://www.slideshare.net/bnunnally/user-experience-ui" title="User Experience Doesn&#39;t Equal User Interface">User Experience Doesn&#39;t Equal User Interface</a><object style="margin:0px" width="425" height="355"><param name="movie" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=ux-not-ui-090831184156-phpapp02&rel=0&stripped_title=user-experience-ui" /><param name="allowFullScreen" value="true"/><param name="allowScriptAccess" value="always"/><embed src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=ux-not-ui-090831184156-phpapp02&rel=0&stripped_title=user-experience-ui" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="355"></embed></object><div style="font-size:11px;font-family:tahoma,arial;height:26px;padding-top:2px;">View more <a style="text-decoration:underline;" href="http://www.slideshare.net/">documents</a> from <a style="text-decoration:underline;" href="http://www.slideshare.net/bnunnally">Brad Nunnally</a>.</div></div>

<h2>Session 5: ASP.Net MVC 
by <a href="http://blog.phatboyg.com/" title="PhatBoyG.com">Chris Patterson</a></h2>
After believing the Windows Mobile session was cancelled (it really wasn't), I popped into the ASP.Net MVC session expecting an overview of MVC, but was presently surprised. Chris did a good job of closing the gaps on the bits of MVC that I've been bothered by in other demos, talks and blog posts; namely the over-dependency on strings. Chris showed how some future/contrib packages allow type safe views, view data and control actions. My next project is slated to be our first step into the MVC space, and I look forward to putting some of Chris's wisdom into action.

<h2>The After Party</h2>
It's late and I've been typing for a while. I'm getting brief, but about to get briefer. The after-party was at Home night club at the casino. It was really swank, but it might have been too swank for me. Maybe I'm unrefined, or unsophisticated, but I would have much rather preferred beer and pizza in a casual environment to fancy hors d'oeuvres and night club drink prices at 6:00 in the evening. It was nice to be able to mix with everyone, although I know I wasted the opportunity to meet several of the presenters and people I follow on Twitter.

<h2>Tomorrow</h2>
I'm looking forward to tomorrow, although I am still undecided if I'll be there for the JumpStart sessions.

Check out <a href="/2009/08/30/st-louis-day-of-net-day-two-overview/">my review of day 2</a>.
