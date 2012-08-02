---
title: There is no ViewData item of type 'IEnumerable<SelectListItem>' that has the key 'myProperty'.
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>While figuring out the ASP.Net MVC 2.0 Preview 2 Expression HtmlHelpers (thats a mouthful), I ran into this error a couple times. It didnt make any sense to me because there shouldnt be ViewData item with the key MyProperty with that type. </p>  <p>It turns out I was doing this:</p>  <pre name="code" class="c#">
&lt;%= Html.DropDownListFor(x=&gt;x.MyProperty, Model.AllMyPropertyListItems) %&gt;
</pre>

<p>It throws this exception when <code>AllMyPropertyListItems</code> is null. </p>
