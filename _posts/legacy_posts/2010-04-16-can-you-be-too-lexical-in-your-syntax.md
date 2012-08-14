---
title: Can you be too lexical in your syntax
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Anyone whom has read any of my recent code knows I love lexical syntax. I really love it when anyone, even our HTML designers, can read our code and understand exactly what is going on. Im not the only one either.</p>  <blockquote>   <p>@MarkBorcherding amen, fellow believer in functionNamesShouldSayWhatTheyDo(AndParameterNamesShouldReflectWhyTheyAreNeededByTheFunction)!</p>    <p><a href="mailto:n@noelweichbrodt">@noelweichbrodt</a></p> </blockquote>  <p>A great example is the terrible Selenium API. It is confusing to even me, at firstonly for a second. Take a look at the following example.</p>  

<pre class="c#" name="code">_selenium.Open(&quot;some.url&quot;);
_selenium.Type(&quot;css=id$=_username&quot;,&quot;homer&quot;);
_selenium.Type(&quot;css=id$=_password&quot;,&quot;beer.is.yummy&quot;);
_selenium.Click(&quot;css=id$=_submit&quot;,&quot;LoginButton&quot;);
_selenium.WaitForPageToLoad(&quot;30000&quot;) 
Assert.Equal(&quot;Homer Simpson&quot;,_selenium.GetText(&quot;css=id$=_userFullName&quot;)); 
</pre>
<p>&#160;</p>

<p>Now that's not terrible. I would even lean to say anyone would know what that does, but what is the css=id$=_username? That looks goofy.&#160; Why do we do that? Take a look at our extensions on top of the Selenium API.</p>

<pre class="c#" name="code">_theBrowser.Types(&quot;Homer&quot;).IntoAspNetControl(&quot;username&quot;);
_theBrowser.Types(&quot;beer.is.yummy&quot;).IntoAspNetControl(&quot;password&quot;);
_theBrowser.ClicksOnAspNetControl(&quot;LoginButton&quot;);
_theBrowser.WaitsForThePageToLoad();
&quot;userFullName&quot;.AspNetControl().TextIn(_theBrowser).ShouldBe(&quot;Homer Simpson&quot;);</pre>

<p>&#160;</p>

<p>It wouldn't be hard to argue the second example is not much more clear. You dont have to remember that CSS selector or why we did the $=_ instead of just =. Overall, Im pretty happy with our API. There is a valid argument that this syntax will take time to learn since any developer reading it will have zero experience with it or know what calls are available, but over time, I think the benefit of its readability out weight its learning curve.</p>

<p>So here is where I am today. I dont like the following code.</p>

<pre class="html" name="code">&lt;input 
    type=&quot;text&quot; 
    id=&quot;&lt;%=Html.IdFor(x=&gt;x.CustomDomainName) %&gt;&quot;
    style='&lt;%= !Model.HasCustomDomainName ? string.Empty : &quot;display:none&quot; %&gt;'
    /&gt;</pre>

<p>&#160;</p>

<p>Its a pretty typical ternary operator. In this case though, I have to explain to our designers what that actually means and how to read it. Im really tempted to create the extension methods I need to have this syntax.</p>

<pre class="html" name="code">&lt;input 
    type=&quot;text&quot; 
    id=&quot;&lt;%=Html.IdFor(x=&gt;x.CustomDomainName) %&gt;&quot;
    style='&lt;%= Model.HasCustomDomainName.IsFalse().Then(()=&gt;&quot;display:none&quot;) %&gt;'
    /&gt;</pre>

<p>&#160;</p>

<p>Again, much more clear, but it feels like Im starting to abuse the extension methods and making a mess of the languagebut it reads so much nicer.</p>
