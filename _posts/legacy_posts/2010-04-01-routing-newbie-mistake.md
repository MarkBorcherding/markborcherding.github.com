---
title: Routing Newbie Mistake
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p><a href="http://www.flickr.com/photos/candiedwomanire/3397197237/"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; margin-left: 0px; border-left-width: 0px; margin-right: 0px" title="008" border="0" alt="008" align="right" src="http://farm4.static.flickr.com/3605/3397197237_543c57dea8_m.jpg" width="240" height="240" /></a>So Im a n00b in some areas and it is painful finding this out sometimes. I spent most of the morning trying to figure out why my ASP.Net Web Site application wasnt routing to my MVC controller that is inside of my ASP.Net MVC Area. </p>  <p>Granted, that is a weird setup so there are a lot of things I thought could possibly go wrong. The real reason was embarrassingly obvious, but not embarrassing enough that I wouldnt post it for the world to see. </p>  <p>What do you see wrong with this route:</p>  <pre class="c#" name="code">context.MapRoute(
    &quot;Default Route&quot;,
    &quot;ServerManagement/{controller}/{action}/{id}&quot;,
    new {   controller = &quot;farms&quot;, 
            action = &quot;index&quot;
        });</pre>

<p>Give up? You <em>have</em> to give a default value if you have a placeholder in the route. In this case we have /{id} in the route, but we never a default value for the id. The following route worked fine. </p>

<pre class="c#" name="code">context.MapRoute(
    &quot;Default Route&quot;,
    &quot;ServerManagement/{controller}/{action}/{id}&quot;,
     new {   controller = &quot;Farms&quot;, 
             action = &quot;index&quot;, 
             id=&quot;&quot;
         });</pre>

<p>Lesson learned!</p>
