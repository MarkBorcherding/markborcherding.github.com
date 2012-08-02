---
title: ReSharper Tip of the Day --More Reminders
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I've stalled with providing tips for a while. My development at work will pickup and I will soon lots of new tips. As we work into using C# 3.0 I am sure ReSharper will continue to impress. For today though, we have a simple reminder.

<strong><em>Alt+Page Up|Page Down</em> goes to the next ReSharper gutter item.</strong>

This just saved me a ton of time. We are currently converting some .Net 2.0 code to target .Net 3.5. In so doing I am going to make use of the new language features. Our domain objects are classes with series of classic properties.

<pre name="code" language="c#">
    private string fooberry;
    public string Fooberry{
        get{ return fooberry; }
        set { fooberry = value; }
    }
</pre>

To convert these to automatic properties I could have copy and pasted <code>{get;set;}</code> after each property name and deleted the rest, but R# made it much easier.<em> Alt+Page Down</em> took me to the next suggest which was to convert to automatic properties.<em> Alt + Enter </em>opened the context window with the first action being convert to auto property. Pressing Enter one last time had it fixed.

<pre name="code" language="c#">
    public string Fooberry{ get;set;  }
</pre>

What made it so effective was I was able to hold down <em>Alt </em>the entire time and press <em>Page Down, Enter, Enter, Page Down, Enter, Enter</em>,etc. until my properties in that file were all changed. <strong>Total time to convert 20 properties...10 seconds.</strong> Try that with copy and paste. I bet it is a bit higher.
