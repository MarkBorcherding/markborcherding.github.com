---
title: Data Annotation Validation of More Complicated Rules
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Using Data Annotation validation is great. Its simple. Its declarative. Its fine and dandy if all you need to validate is simple, single property rules.</p>  <pre class="c#" name="code">[Required] 
public string FirstName {get;set;}<p></p></pre>

<p>The problem is, we are never that fortunate to only have simple rules like that. Even rules only slightly more complex made me scratch my head at first. For example, take the following rule:</p>

<blockquote>
  <p>If the address is inside the United States, then State is required.</p>
</blockquote>

<p>Simple enough, but how to do it with Data Annotation. Initially I decided not to validate this rule via annotation and did something like the following in my controller action.</p>

<pre class="c#" name="code">var additionalErrors = MyViewData.ValidateAddress(dataFromMyForm);
foreach (var errorInfo in additionalErrors)
{
    ModelState.AddModelError(errorInfo.PropertyName, errorInfo.ErrorMessage);
}</pre>

<p>That works and all, but it feels really sloppy. Not only does it feel sloppy, but now my model validation lives in two places; the model binder and the controller action. Yuck! And whats even worse, is I have to consider the model validation in my tests for that controller action. </p>

<p>It would be better to do the validation via a custom validation attribute, but how to do that on the class? First lets create a custom validation attribute.</p>

<pre class="c#" name="code">public class UsaAddressRequiresStateAttribute : ValidationAttribute
{
    public override string FormatErrorMessage(string name)
    {
        return &quot;State is required.&quot;;
    }

    public override bool IsValid(object value)
    {
        var address = value as IAddress;
        if (address == null) return true;
        if (address.Country == &quot;United States&quot;) 
           return !string.IsNullOrEmpty(address.State);
        return true;
    }
}</pre>

<p>Pretty simple right? And dont worry. Were not actually using <code>&quot;United States&quot;</code> in our production application. Now, decorate the class with that attribute.</p>

<pre class="c#" name="code">[UsaAddressRequiresState]
public class MyViewData : IAddress {
}</pre>

<p>In my particular case, my view data class implements <code>IAddress</code>, which lets me name my view data address fields whatever they want and still expose them to the validator. <em>The limitation with this method is you can only validate one address on each form.</em> There is surely a better way to do this, but I didnt need to discover it right now.</p>

<p>Thats it. The model binder will now check that validation when binds the model and well see the errors in the model state. if you want the to appear in JavaScript if you do client side validations, I suggest you check you the <a href="http://haacked.com/archive/2009/11/19/aspnetmvc2-custom-validation.aspx">Phil Haack post about custom validation</a>.</p>
