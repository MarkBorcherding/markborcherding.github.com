---
title: ReSharper Tip of the Day -- Move to the Other Part 
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Here is another cool one.at least to me. In my test classes Ive been trying to fake out my dependencies instead of mock themjust for a change and most of the time I dont really want to assert how the class used the dependency, just that it gives me the correct result.

I create nested private classes using ReSharper. It puts it at the bottom of my current class which is fine. However, all that is noise to me for the most part, so I moved them to a partial class. I have MyClassTests and MyClassFakes, which actually has a MyClassTests partial class that holdsyou guessed it, all the fakes.Anyway, here is how ReSharper will move my classes around. Itll move whatever, is selected. In this case Im moving my field bar, but in real life I move my nested class.

With my cursor on bar, I use the trusty<em>Alt + Enter</em>. And tell it to move it.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image002_2.jpg"><img title="clip_image002" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image002_thumb.jpg" border="0" alt="clip_image002" width="318" height="196" /></a>

It moves it down to the other part.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image004_2.jpg"><img title="clip_image004" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image004_thumb.jpg" border="0" alt="clip_image004" width="427" height="202" /></a>

More than one partial class? No problem.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image006_2.jpg"><img title="clip_image006" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayMovetotheOtherPartHo_7CEC/clip_image006_thumb.jpg" border="0" alt="clip_image006" width="418" height="174" /></a>
