---
title: What Am I Testing
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I've been spending the better part of two days doing this same process over and over. It doesnt feel like Im testing anything of value.

I am not doing it in the C# 3.0ish way, but it is better to explain it that way.I have a class and a faade (MyFacade) that I want to extend and test.
<pre name="code" language="csharp">
class Foo {
     public string Name { get; set; }
}

class MyFacade {
     public IMyDependency Depend { get; set; }
}

interface IMyDependency {
     IList&lt;Foo&gt; GetAllFoos();
}</pre>
So I write my test first like a good boy person should. I know my faade should give me back a list of the Name properties from the Foo objects it knows about.
<pre name="code" language="csharp">
[TestFixture]
public class MyFacadeTests {
    [Test]
    public void GetFooNames_ReturnsOnlyName() {
        FakeDependancy fake = new FakeDependency();
        MyFacade m = new MyFacade() { Depend = fake };
        Assert.That(m.GetFooNames(), Is.EquivalentTo(fake.FakeFoos.Select(x =&gt; x.Name)));
    }
}</pre>
I need that FakeDependency, so I go ahead and create that. This would be a like my repository that will allow me to initialize the fake data.
class FakeDependency : IMyDependency {
<pre name="code" language="csharp">    // My local fake repository
    public IList&lt;Foo&gt; FakeFoos = new List&lt;Foo&gt;{
                new Foo{ Name="A"},
                new Foo{ Name="B"},
                new Foo{ Name="B"}};

    public IList&lt;Foo&gt; GetAllFoos() {
        return FakeFoos;
    }
}</pre>
OK. So now that I have that, I add my GetFooNames stub to MyFacade.
<pre name="code" language="csharp">class MyFacade {
    public IMyDependency Depend { get; set; }

    public IList&lt;string&gt; GetFooNames()
    {
        return null;
    }
}</pre>
Run my test. It fails. Good. Now to implement that method.uhh I just copy my assert statement:
<pre name="code" language="csharp">fake.FakeFoos.Select(x =&gt; x.Name)</pre>
replace fake.FakeFoos with Depend.GetAllFoos() and I get:
<pre name="code" language="csharp">class MyFacade {
    public IMyDependency Depend { get; set; }

    public IEnumerable&lt;string&gt; GetFooNames() {
        return Depend.GetAllFoos().Select(x =&gt; x.Name);
    }
}</pre>
Build it. Run it. It passes. What did I really test since I just copied the assert statement into the implementation body and changed the source? Did I test anything? That my copy code does the same thing in two places? Am I wasting time?
I rolled it around with a friend and decided to take out the select in the assert statement and replace it with a declarative list so it would look like this:
<pre name="code" language="csharp">Assert.That(m.GetFooNames(), Is.EquivalentTo(new[]{"A","B","C"}));</pre>
That make me feel a little less "copy and pastey", but now I have to know my fake is setup to give me three letters for the names. Lets add a little bit to the fake to make it easier to configure. I am hesitant to do this since I dont want to add code to my test classes, but I think in the end it is more readable than a more raw configuration.
So I added this to my test class:
<pre name="code" language="csharp">public FakeDependency With(int i)
{
    FakeFoos.Clear();
    for (int j = 0; j &lt; i; j++)
    {
        FakeFoos.Add(new Foo());
    }
    return this;
}

public FakeDependency Named(string name)
{
    for (int i = 0; i &lt; FakeFoos.Count; i++)
    {
        // We want them to be 1 based and not zero based
        FakeFoos[i].Name = string.Format("{0} {1}", name, i + 1);
    }
    return this;
}</pre>
And use it in my test like this:
<pre name="code" language="csharp">[Test]
public void GetFooNames_ReturnsOnlyName() {
    FakeDependency fake = new FakeDependency().With(3).Named("Fake");
    MyFacade m = new MyFacade() { Depend = fake };
    Assert.That(m.GetFooNames(), Is.EquivalentTo(new[]{"Fake 1","Fake 2","Fake 3"}));
}</pre>
Im a lot happier with that than copying the same code from the test to the implementation classes.
