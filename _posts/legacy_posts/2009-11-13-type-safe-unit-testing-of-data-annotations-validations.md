---
title: Type Safe Unit Testing of Data Annotations Validations
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Were using the Data Annotations Validators in ASP.Net MVC 2.0, but there wasnt a really great way to unit test them. Ive read <a href="http://bradwilson.typepad.com/blog/2009/04/dataannotations-and-aspnet-mvc.html">Brad Wilsons blog post</a> about how to set them up and unit test them, but I didnt like how you relied on the name of the property as a string.</p>  <pre class="c#" name="code">// Arrange
var propertyInfo = typeof(Contact).GetProperty(&quot;FirstName&quot;);</pre>

<p>It would be nicer if that used lambda expressions to get the name of the property, so I set out to do just that. Before we begin, I need to remind you, as always, <strong>I dont know what Im doing</strong>. This is my first tiny venture into expression trees so it is possible isnt the best way to do things, but so far, its working for me.</p>

<p>I created a base Specification to wrap up a lot of the messy bits of getting property names by lambdas. I took a look at <a href="http://aspnet.codeplex.com/sourcecontrol/changeset/view/23011?projectName=aspnet#266392">how the ASP.Net MVC helpers did it</a> and roughly followed their pattern.</p>

<pre class="c#" name="code">public class DataAnnotationSpecification&lt;T&gt; : Specification
{

    
    public PropertyInfo Property(Expression&lt;Func&lt;T,object&gt;&gt; op)
    {
        return Property(GetInputName(op));
    }

    public PropertyInfo Property(string propertyName)
    {
        return typeof (T).GetProperty(propertyName);
    }

    public static string GetInputName&lt;TProperty&gt;(Expression&lt;Func&lt;T, TProperty&gt;&gt; expression)
    {
        // not sure I totally understand this
        if (expression.Body.NodeType == ExpressionType.Convert)
        {
            var ue = (UnaryExpression)expression.Body;
            return GetInputName((MemberExpression) ue.Operand );                
        }

        if (expression.Body.NodeType == ExpressionType.MemberAccess)
        {
            return GetInputName((MemberExpression)expression.Body);                
        }
        throw new NotImplementedException();            
    }

    private static string GetInputName(MemberExpression memberExpression)
    {
        return memberExpression.Member.Name;
    }

}</pre>

<p>I know this probably doesnt cover an exhaustive list of expressions, but were only talking about Property access tests here so were probably in the clear.</p>

<p>To make things a bit nicer, I also created some extensions off PropertyInfo to help setup their assertions.</p>

<pre class="c#" name="code">public static class AttributeAssertions
{

    public static void ShouldNotBeRequired(this PropertyInfo @this)
    {
        @this.ShouldNotHaveAttribute&lt;RequiredAttribute&gt;();
    }

    public static void ShouldBeRequired(this PropertyInfo @this)
    {
        @this.ShouldHaveAttribute&lt;RequiredAttribute&gt;();
    }

    private static T PropertyAttributeOn&lt;T&gt;(ICustomAttributeProvider propertyInfo)
    {
        return propertyInfo.GetCustomAttributes(typeof (T), false)
            .Cast&lt;T&gt;()
            .FirstOrDefault();
    }

    public static void ShouldHaveAttribute&lt;T&gt;(this PropertyInfo @this) 
    {            
        PropertyAttributeOn&lt;T&gt;(@this).ShouldNotBeNull();
    }
    public static void ShouldNotHaveAttribute&lt;T&gt;(this PropertyInfo @this)
    {
        PropertyAttributeOn&lt;T&gt;(@this).ShouldBeNull();
    }
}</pre>

<p>We only have the <code>ShouldBeRequired</code> and <code>ShouldNotBeRequired</code> right now, but you could see it will be easy to extend upon them.&#160; The finished spec looks something like this.</p>

<pre class="c#" name="code">public class When_testing_the_state_of_the_CustomerViewData 
    : DataAnnotationSpecification&lt;CustomerViewData&gt;
{
    [Then] public void the_customer_first_name_is_required()
    {            
        Property(x =&gt; x.CustomerFirstName).ShouldBeRequired();
    }

    [Then] public void the_customer_middle_name_is_not_required()
    {
        Property(x =&gt; x.CustomerMiddleName).ShouldNotBeRequired();
    }

    [Then] public void the_customer_last_name_is_required()
    {
        Property(x=&gt;x.CustomerLastName).ShouldBeRequired();
    }

    [Then] public void the_email_address_is_required()
    {
        Property(x=&gt;x.CustomerEmailAddress).ShouldBeRequired();
    }

}</pre>

<p>Thats not so bad, and it stands up to any refactoring we might do.</p>
