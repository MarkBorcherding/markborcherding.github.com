---
title: Are extensive extension method an anti-pattern
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>I was explaining my dilemma to a Java friend and the e-mail ended up being fairly interesting, so I thought I would share it. </p>  <blockquote>   <p>I'm sure Java has extension methods, but I'll give it a once over just in case.&#160; You can extend existing classes without sub-classing by extension methods.</p>    <pre>public static IEnumerable&lt;SelectListItem&gt; 
                            AsSelectListItems( this IEnumerable&lt;Person&gt; listOfPeople){
   IList&lt;SelectListItem&gt; selectListItems = new List<selectlistitems>();
   foreach(var person in listOfPeople){
      selecListItems.Add(new SelectListItem(person.ID, 
					    string.Format(&quot;{0} {1} {2}&quot;, 
                                                          person.First, 
                                                          person.Middle, 
                                                          person.Last));
   }
   return selectListItems;
}</pre>

  <p>Right. So the <code>this</code> operator tells the compiler to basically create this function:</p>

  <pre>public static IEnumerable&lt;SelectListItem&gt; 
                           AsSelectListItems(IEnumerable&lt;Person&gt; listOfPeople);</pre>

  <p>And invoke it every time you see this:</p>

  <pre>IEnunerable&lt;Person&gt; p = myService.GetAllPeople(); 
IEnumerable&lt;SelectListItem&gt; s = p.AsSelectListItems();</pre>

  <p>You probably knew all this, but it explains how we are using them. We end up calling a lot of extension methods off other extension methods. </p>

  <pre>myViewData.PersonSelectListItems = myService.GetAllPeople()
                                                   .AsSelectListItems()
                                                   .OrderedByText()
                                                   .StartingWithAnEmptyItem();</pre>

  <p>In this example we have three extension method calls and I think it really makes the code much more readable, but it makes testing this code a little more difficult. Obviously, the myService is a mocked dependency which will return a fake list of people, but the other extension method calls cannot be mocked, and the scope of the test bleeds a bit. </p>

  <p>I like the syntax it gives, but now I'm going to test potentially four classes when I should be testing only one. </p>
</blockquote>

<p>This gets pretty pandemic in our code. Especially trying to make Seleniums API and the assertion API of Nunit and xUnit more fluent.</p>
