---
title: Mixing WebForms and MVC
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>We have a moderately large WebForms web application, but we are trying to transition to MVC. On the surface it sounds pretty simple. We can create controllers to do small functions of our page. we can be AJAXy if we so desire and all will be great. </p>  <p>Lets give it a try.&#160; We want to add a customer search to our master page.&#160; Simple enough right?</p>  <p><a href="/wp-content/uploads/2010/07/image.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2010/07/image_thumb.png" width="643" height="431" /></a></p>  <p>All I really need is a controller that redirects to our existing search page.&#160; No problem. Seems simple enough. Let me code up the controller in a simpler, reduced test case.</p>  <p>Done in 15 minutes.</p>  <p>OK. Now we just need to drop a tiny form that posts to our controller on our master pagewait&#160; a minute. WebForms has a HUGE form that takes up the entire page! I cant nest a form inside a form. This means I cant post inside the form to anywhere but the same form.</p>  <p>I know&#160; what youre thinking. I shouldnt <em>post </em>to search anyway. I should <em>get</em> instead. Yes. I agree, but this example is contrived. I actually came across this problem when I wanted to create a controller that merged two customers together and redirect to the surviving customer. In that case we <em>do</em> want to postso bear with my invalid semantics. </p>  <p>Anyway. We cant POST. hmm..I guess we have to do something like this (remember in real life Im merging and not searching&quot;):</p>  <pre name="code" css="c#">[HttpGet] public ActionResult SearchViaGet(string searchTerm, bool isQuickSearch){}</pre>

<p>It feels really nasty. What makes it even worse is we have to use Ajax to pull the values from the inputs and build the request URL. If they dont have JavaScript enabledoh well. No search for you!</p>

<p>I cant really think of a way around this. With MVC, and without the giant WebForms form, this page would comprised of several tiny forms. For now, the no JS problem isnt that big of a deal. The app is used by internal users only so if they dont have JS enabled we can just laugh at them until they either turn it on, or we feel bad that they dont know how to turn it on, and turn it on for them.</p>

<p>Where we do have a problem is when we try to use pages like this via our ancient mobile devices. We cant trust JS on those bricks and if I had to bet, there would be no search for them either.</p>
