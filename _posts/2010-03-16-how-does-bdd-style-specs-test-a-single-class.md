---
title: How does BDD style specs test a single class?
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>I really like how BDD specs read, especially in the test result window. We dont use anything like <a href="http://github.com/machine/machine">MSpec</a> yet. Im still trying to get testing to gain momentum and making them look as far from regular code as MSpec does makes it that much more difficult. </p>  <p>We do have a pattern we follow:</p>  <pre class="c#" name="code">public class When_something_happens : Specification{

  Foo somethingUnderTest;
  Bar result;

  override public void Given(){ 
    somethingUnderTest = new Foo(...);    
  }

  override public void When(){
    result = somethingUnderTest.doesSomething();
  }

  [Then] public void the_result_should_not_be_null(){
     result.ShouldNotBeNull();
  }

}</pre>

<p>&#160;</p>

<p>We just created a base Specification, renamed the xUnit FactAttribute to ThenAttribute (probably unnecessary) and then created a load of extensions of object for the ShouldBeWhatevers. There is more noise than there would be with MSpec, but that's the tradeoff for looking like code.</p>

<p>Im pretty happy with all this and it works pretty well, but what Im finding is that the BDD specs I write before I write a class often dont test what the class does in the end, after that work has been off loaded to a dependency. Take for example the following simple spec. (bits have been left out for simplicityknow it wont compile)</p>

<pre class="c#" name="code">public class When_creating_an_order_invoice_view_model_from_an_order : Specification {

  override public void Given(){
    factory = new OrderInvoiceViewDataFactory();
    order = new Order{ FirstName = &quot;Homer&quot;, 
                       LastName  = &quot;Simpson&quot;,
                       Items     = new []{
                                     new LineItem{ Product =&quot;Duff 6 pack&quot;, 
                                                            Price = 4.99m, }
                                     new LineItem{ Product =&quot;Duff can koozie&quot;, 
                                                            Price = 0.99m, }
                                   }	
  }

  override public void When(){
    invoice = factory.BuildFrom(order);
  }

  [Then] public void the_total_should_be_the_sum_of_the_items(){
    invoice.Total.ShouldBe(4.99m + 0.99m);
  }

}</pre>

<p>&#160;</p>

<p>Overlooking the simplicity of the spec, it seems reasonable right?</p>

<p>Heres my problem. I build my factory to calculate the total, but as soon as I do I realize that totaling the order in the factory that builds the view data violates <a href="http://en.wikipedia.org/wiki/Single_responsibility_principle">SRP</a>.</p>

<p>Thats easy enough to fix. I just end up with a factory that looks like this:</p>

<pre class="c#" name="code">public class OrderInvoiceViewDataFactory{
  public OrderInvoiceViewDataFactory(IOrderTotalCalculator calculator){
    //...
  }
}</pre>

<p>&#160;</p>

<p>Now I mock that out in my spec:</p>

<pre class="c#" name="code">public class When_creating_an_order_invoice_view_model_from_an_order : Specification {
  override public void Given(){
    // ..

    mockCalculator = new Mock&lt;(IOrderTotalCalculator&gt;();
    mockCalculator
      .Setup(x=&gt;x.CalculateTotal(order))
      .Returns(3.14m);
    factory = new OrderInvoiceViewDataFactory(mockCalculator.Object);

  }

  [Then] public void the_total_should_be_the_sum_of_the_items(){
    // we only need to test what out mock returns
    invoice.Total.ShouldBe(3.14m);
  }

}</pre>

<p>&#160;</p>

<p><strong>and abracadabramy spec tests nothing.</strong></p>

<p>From a spec perspective its valid, but from a test perspective, all it tests is that my mocking framework works and Im making that call to it like I expect.</p>

<p>So what do you do? All the test around the calculations move to another file and the spec&#160; gets simplified to just test the interaction with the dependencies?</p>

<pre class="c#" name="code">[Then] public void the_calculator_was_called_to_calculate_the_total(){
   mockCalculator.Verify(x=&gt;x.CalculateTotal(order),Times.Once);
}</pre>

<p>&#160;</p>

<p>What I loose here is my nice test result that anyone can look at an understand. All my non-techy folks need to look at several different places to see if that order invoice is be calculated correctly.</p>

<p>You could make this an integration test and test the calculator as well, but I dont like that idea either.</p>

<p>This is probably a sign that Im not writing my specs correctly or I should identify this is going to be factored out sooner. This hasnt been the case so far. Especially when we are translating something from a graph of objects to a flat representation&#160; for a model in our MVC app, a lot of the work ends up being factored out or pushed into <a href="http://www.codeplex.com/AutoMapper">AutoMapper</a> where we need to write a different tests for it. </p>

<p>When we are done with the refactoring, the original spec for the class is very skinny, which is good, but as I said, seeing the results of how the story is progressing is more difficult. Maybe that is where my focus needs to be. How do you tie the specs to a specific story and see the results in an aggregated manner?</p>
