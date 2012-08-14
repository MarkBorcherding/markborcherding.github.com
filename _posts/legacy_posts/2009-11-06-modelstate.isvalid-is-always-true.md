---
title: ModelState.IsValid is always true
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>We ran into a snag with using the new default Data Annotations Validation in ASP.Net MVC 2.0 Preview 2. Maybe it isnt a snag, but it is not the behavior I would have expected. </p>  <p>Take the following model:</p>  <pre class="c#" name="code">public class Person
{       
  public string ID { get; set; }

  public string FirstName { get; set; }
  public string LastName { get; set; }

  [Required (ErrorMessage = &quot;Required&quot;)]        
  public string EmailAddress { get; set; }
}</pre>
Pretty straight forward, but if you post this form: 

<pre class="html" name="code">    &lt;form action=&quot;/person/edit&quot; method=&quot;post&quot;&gt; 
        &lt;input type=hidden name=&quot;id&quot; id=&quot;id&quot; value=&quot;&quot; /&gt; 
        &lt;input type=&quot;text&quot; id=&quot;firstname&quot; name=&quot;firstname&quot; /&gt;<br /> 
        &lt;input type=&quot;text&quot; id=&quot;lastname&quot; name=&quot;lastname&quot; /&gt;<br /> 
        &lt;input type=&quot;submit&quot; /&gt; 
    &lt;/form&gt; </pre>
To this controller action: 

<pre class="C#" name="code">[HttpPost] public virtual ActionResult Edit(Person data)
{
   if (!ModelState.IsValid) throw new ItBrokeException();
   return View();
}</pre>
Personally, I would expect every post of that form to show up as invalid, but infact, it is always true. Add the following input to the form and it works. 

<pre class="html" name="code">   &lt;input type=&quot;text&quot; id=&quot;emailaddress&quot; name=&quot;emailaddress&quot; /&gt; &lt;br/&gt;
</pre>
After that, the <code>ModelState.IsValid</code> returns false, like it should.<p></p>
