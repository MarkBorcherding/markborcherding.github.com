---
title: Refactor rename on LINQ to SQL Classes
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>This is a quick, dirty work around to renaming the properties of the LINQ to SQL classes. Say you have a simple DBML class you want to rename. </p>  <p><a href="/wp-content/uploads/2009/12/image3.png"><img style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto" title="image" border="0" alt="image" src="/wp-content/uploads/2009/12/image_thumb3.png" width="224" height="161" /></a></p>  <p>Simple enough right? Just click in there and edit the WidgetName to Name right? Wrong! You have code like this.</p>  <pre class="c#" name="code">public Widget CreateNewWidget(string name, string description)
{
    return new Widget {
        WidgetDescription = description, 
        WidgetName = name
    };
}</pre>

<p>Youre going to abandon all those calls to WidgetName and do a search and replace refactor. That sucks. So rename it to WidgetName2 for now and let all the references break.</p>

<p><a href="/wp-content/uploads/2009/12/image4.png"><img style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto" title="image" border="0" alt="image" src="/wp-content/uploads/2009/12/image_thumb4.png" width="233" height="167" /></a> </p>

<p>That breaks our code.</p>

<p><a href="/wp-content/uploads/2009/12/image5.png"><img style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto" title="image" border="0" alt="image" src="/wp-content/uploads/2009/12/image_thumb5.png" width="545" height="155" /></a> </p>

<p>Fine for now. Create a partial class for the Widget.cs and add our WidgetName back in</p>

<pre class="c#" name="code">public partial class Widget
{
    public string WidgetName { get; set; }
}</pre>

<p>Use ReSharper to rename that property to name.</p>

<p><a href="/wp-content/uploads/2009/12/image6.png"><img style="border-bottom: 0px; border-left: 0px; display: block; float: none; margin-left: auto; border-top: 0px; margin-right: auto; border-right: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/12/image_thumb6.png" width="580" height="218" /></a> </p>

<p>Then delete the partial class, or property and rename the property in the DBML to Name. </p>

<p>Done.</p>
