---
title: You sneaky deferred execution!
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>As Ive mentioned we have a series of Extension methods that help with some trivial, but isolated tasks. Here is an example.</p>  <pre class="c#" name="code">public static IEnumerable&lt;SelectListItem&gt; CreatePaymentTypeDropDownListItems(
                                          this IQueryable&lt;PaymentType&gt; @this)
{
    return  @this
            .OrderBy(x =&gt; x.Description)
            .Select(x =&gt; new SelectListItem
                             {
                                 Value = x.Code, 
                                 Text = x.Description, 
                             })
            .MarkAsSelected(x=&gt;x.Text == CreditCard);
}</pre>

<p>Simple enough right? The <code>MarkAsSelected</code> is another extension method we have to help out. Its not all that exciting, but here it is.</p>

<pre class="c#" name="code">public static IEnumerable<selectlistitem> MarkAsSelected(this IEnumerable<selectlistitem> @this, Func<selectlistitem  ,BOOL> where)
{
    var items = @this.Where(where);
    foreach (var item in items)
    {
        item.Selected = true;
    }
    return @this;
   
}</pre>

<p>Simple enough right? But the credit card payment type was never getting defaulted with the select value. We have unit tests around <code>MarkAsSelected</code> and it works! Whats the problem? Lets try something really quick.</p>

<pre class="c#" name="code">public static IEnumerable&lt;SelectListItem&gt; CreatePaymentTypeDropDownListItems(
                                          this IQueryable&lt;PaymentType&gt; @this)
{
    return  @this
            .OrderBy(x =&gt; x.Description)
            .Select(x =&gt; new SelectListItem
                             {
                                 Value = x.Code, 
                                 Text = x.Description, 
                             })
            .ToArray()
            .MarkAsSelected(x=&gt;x.Text == CreditCard);
}</pre>

<p>That works! Whats up? Oh you sneaky deferred execution. I bet its you! Im not an expert, but here is my best guess. When the <code>MarkAsSelected</code> does its foreach, it asks the <code>@this</code> to create an enumerator. It does, but since it is from an <code>IQueryable&lt;T&gt;</code>, it now executes all that deferred execution in the <code>Select</code> and <code>OrderBy</code>. Fair enough. The enumerator spits out all the <code>SelectListItems</code> we want/need. </p>

<p>We pass on the enumerable incase we want to do something after it, and actually we do. Down the road we want to enumerate again. The <code>Select</code> and <code>OrderBy</code> kick in again and we get all brand new <code>SelectListItems</code>. </p>

<p>Throwing that <code>ToArray</code> in there gets us out of operating on the <code>IQueryable&lt;T&gt;</code>, does the <code>Select</code> and <code>OrderBy</code> and lets us operate on a straight list. Makes sense, but not obviously apparentat least to me.</p>

<p>But you know what? After all that, I think I just prefer this. </p>

<pre class="c#" name="code">public static IEnumerable&lt;SelectListItem&gt; CreatePaymentTypeDropDownListItems(
                                          this IQueryable&lt;PaymentType&gt; @this)
{
    return  @this
            .OrderBy(x =&gt; x.Description)
            .Select(x =&gt; new SelectListItem
                             {
                                 Value = x.Code, 
                                 Text = x.Description, 
                                 Selected = (x.Description == CreditCard)
                             });
}</pre>

<p>No need to overcomplicate the problem right?</p>
