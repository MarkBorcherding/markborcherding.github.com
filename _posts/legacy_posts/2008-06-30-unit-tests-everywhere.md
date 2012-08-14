---
title: Unit Tests Everywhere
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Recently Ive been able to extend my unit test code coverage as Ive been introducing more features into our code base. I know this is something that should<em>always</em>be done, but for whatever reason, thats not the case. What Ive come to notice is our current method of organizing our unit test makes adding new features and test for new features awkward.

Currently our unit tests align perfectly with the class they test. So for example, if we have a class:
<pre name="code" language="csharp">namespace MyCompany.Domain{
     public class Foo{}
}</pre>
<span class="code">We have, or should have, a test fixture in a separate assembly that looks like this:</span>

<pre name="code" language="csharp">
using MyCompany.Domain;
using NUnit.Framework;
namespace MyCompany.Domain.Tests{
  [TestFixture]
  public class FooTests{}
}
</pre>

<span class="code">This is probably a pretty typical strategy for organization. It is intuitive where to find tests for a type. Were Im loosing my taste for this method is as the solution grows to several assemblies or layers, adding new unit tests for a specific feature becomes a scattered mess of changes. If I need to add a new field, I add new tests in the<span style="font-family: con;">UI.Tests</span>, the<span style="font-family: con;">Domain.Tests, Repository.Tests, Core.Tests</span>, etc. Makes sense though right? You have to pass that new field through all the layers. Im ok with the number of tests I need to write, but I dont like having to go to eight different places to run them when I want to test my feature. It would be nice to align them them to the feature, or tag them in such a way I could find them easily. It<strong>could be that we are over layered and that is the real problem</strong>. We could be an<a href="http://www.imdb.com/title/tt0126029/">onion</a>.</span>
<blockquote>Shrek: Example? Okay, er... ogres... are... like onions.
Donkey: [sniffs onion] They stink?
Shrek: Yes...NO!
Donkey: Or they make you cry.
Shrek: No!
Donkey: Oh, you leave them out in the sun and they turn brown and start sproutin' little white hairs.</blockquote>
We are definitely an onion.or an ogre, but thats a whole different analogy.

There is a nice<a href="http://www.code-magazine.com/Article.aspx?quickid=0805061">article in CoDe Magazine by Scott Bellware</a>that talks about BDD. Most of it I didnt see as valuable to my every day activities until he started talking about<a href="http://code.google.com/p/specunit-net/">SpecUnit .Net</a>. It was, in theory, what Ive been looking for. Align my tests with my features/defects/requirements / whatever. SpecUnit .Net does some nice human readable report generation that I dont need, but why would I need a new tool when I could just categorize my tests in folders that line up with my real world problems.

That gets me close, but there is no way to run the entire category without using the command line. Still doable, but not as nice as ReSharpers unit test runner. It would be nice to get a<em>Run all tests in this category</em>from the context menu, but Im not sure if that would be easy to do across the different frameworks. Again it would be nice to save my unit test session so I dont loose it every time I close the IDE.

While were dreaming, Maybe we could invert the relationship and make the class under test and attribute and the tests themselves could align directly with the requirements. Something like this for example:
<pre language="csharp" name="code">
[Test][TypeUnderTest(typeof(Foo))] public void Correctly_Calculates_Bar(){
    //...
}</pre>


Or we could even get fancy with generics:
<pre name="code" language="csharp">[Test&lt;Foo&gt;]  
public void Correctly_Calculates_Bar(){
    //...
}</pre>

The IDE, ReSharper or someone could let me run all the tests for Foo if I wanted.

After Joshs comments I thought I would add a couple screen shots of using the Category attribute to group the tests as needed. You can apply the Category attribute to the method or to the TestFixture.
<pre name="code" language="csharp">    
    [TestFixture]
    public class MyClassTests {

        [Category("Add the ability to do work")]
        [Test] public void DoWork_WithNoArgs_DoesWork(){  }

        [Category("Add the ability to do additional work ")]
        [Category("Add the ability to do work")]
        [Test]
        public void DoWork_WithAllArgs_DoesWork() {   }
    }</pre>


You can select Categories from the unit test runners<em>Group by:</em>combo box.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/UnitTestClutter_B289/image_2.png"><img title="image" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/UnitTestClutter_B289/image_thumb.png" border="0" alt="image" width="381" height="193" /></a>

It then will group your tests by their category. I did find the UI a bit buggy. At first it wasnt applying the grouping, but after a couple attempts they started to show up.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/UnitTestClutter_B289/image_4.png"><img title="image" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/UnitTestClutter_B289/image_thumb_1.png" border="0" alt="image" width="404" height="190" /></a>

Thanks again Josh. That will keep me content for the time being. Now if I could only inspect the entire solution for tests in the category I would<em>really</em>happy.
