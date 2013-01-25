---
title: BDD Tool Showdown
layout: post
description: "Something really cool"
category:
tags: [ ]
---

I've been doing, or trying to do BDD for about a year now. It's been a journey and it feels like after each week I find something I want to do differently. In the past few months, it's been the choice of testing tools.

# In The beginning

Similar to most people's experience with testing on the .Net platform, it begins with NUnit, then to xUnit.net. The differences there aren't really that important for this topic. I wasn't doing _true_ BDD, but I was writing _BDDish_ type tests.

{% highlight c# %}
    [TestFixture] public When_something_happens {
      public When_something_happens(){
        Given();
        When();
      }

      public void Given(){
        // setup context
      }

      public void When(){
        // what I'm testing
      }

      [Test] public void then_bar_should_happen(){
        // make sure it happened
      }
    }
{% endhighlight %}

Now that's not _that_ bad. It works and is sorta BDD. It was good enough to carry us for six months or so.

What's nice about this is it fits into the existing build scripts. We already have Nunit (or xUnit.net) test. We already run them on our CI server and we already report their success or failure. There is nothing more to do.

# Cucumber

I've been playing with Ruby, and Rails, for some time and really love Cucumber. Cucumber is really amazing when testing Ruby, and more specifically Rails. There are gems that make setting up test data a snap. It's as beautiful and fun as writing tests are ever going to be...in Ruby.

Now I admit I looked at driving our acceptance tests in Ruby, using Cucumber and RSpec. The thought of using Ruby, or rather _more_ Ruby than Rake, at work was exciting, but it wasn't right for us. Setting up the context in the database was all rework. There had to be a better way.

# Cuke4Nuke

Cucumber is great, but didn't fit that well to our .Net environment, but Cuke4Nuke looks to bridge that gap. It would let us write our specs in Gherkin and our steps in NUnit. After some time spent working on the setup, it started to work, but it didn't feel that great. Honestly, I can't remember why, but I didn't really like it.

The most important benefit for us was it got some of our tests in Gherkin.

# SpecFlow

We started using [SpecFlow](http://www.specflow.org/) a few weeks after using Cuke4Nuke. It's basically the same setup (from my perspective) as Cuke4Nuke. It has specs written in Gherkin and Tests written in NUnit. It was much easier to get up and running.

What I think is the biggest benefit of SpecFlow over Cuke4Nuke was the use of build providers to create the NUnit test fixture file. Why this is so huge is I can be in Visual Studio, smack my keyboard chord to run my tests (or use your favorite GUI tool) and boom. It runs.

Don't get me wrong. I love my command line, but I like that it boils down to an NUnit test. This is also good news for our build server. It is already running and reporting NUnit tests. Nothing more to do.

There are some draw backs to SpecFlow. The steps aren't very DRY.

{% highlight c# %}
    [Given(@"a foo exists")]
    public void Given_a_foo_exists(){
      _aFoo = new Foo();
    }
{% endhighlight %}

Not that bad, but it does start to be a pain. It uses the regular expression in the method attribute to match against the steps in the feature file. While this redundancy is something I don't like, it also offers a lot of flexibility.

    :::java
    [Given(@"there (?:are|is) (.*) foo(?:s?)"]
    public void Given_foos(int amount){
      _foos = new List<Foo>();
      // add as many as amount
    }

What I like is I can now match `Given there are 5 foos` and `Given there is 1 foo` with the same statement. This lets the features read more naturally with little redundancy.

# StorEvil

[StorEvil](http://github.com/davidmfoley/storevil) is the newest testing framework to come to my attention, and they are doing some really amazing things. I am still really new to this tool, so it's best if you watch their screencasts.

What I really like about it is there are no redundancies with the regular expression to match the step definition and the method name. At first I was a little worried they would drop the ability to have parameterized step definitions, but they account for that with special tokens in the method names (e.g. `public void Given_there_are_arg0_foos(int amount){}`).

But wait! There's more! You don't need to write a step definition for those really simple steps like `Then the name should be Bob`. How does it work? Watch the screencast. It really is brilliant. I'm not sure this feature will replace all the `Then` steps. Something like `Then the number of foos should be 2` might be more awkward this way that a simple step.

It might be too premature for me to say what I don't like about StorEvil, especially since I haven't played with it yet, but I'll be kind.

It looks like it has its own runner, which means there is some config that goes along with it. This will probably reduce as the tool matures, but SpecFlow fit nicely into my existing tooling, with only me having to say "Here's another NUnit assembly." That's nice. I like how I have tooling that already reruns my NUnit tests when I build, and now I'd have to workout something for StorEvil.

Even though I said the redundancy of SpecFlow's regular expressions was a drawback, it does offer a lot of flexibility while writing tests. StorEvil uses reflection to find it's steps so I would probably end up needing a `Given_there_is_1_foo()` and `Given_there_are_arg0_foos()` step. Not that big of a deal since one will just call the other.

It would be nice to write something like this.

    :::java
    Given(@"there (?:are|is) (.*) foo(?:s?)", () =>
      _foos = new List<Foo>();
      // add them all
      );

You could still find the `should` steps automagically and skip writing that test. The drawback here is you would need a common base class to get that `Given` method right on step class. Let's drop all those underscores and look a little more like RSpec.

# Overall

I will definitely look into StorEvil and keep my eye on it, but the zero friction of SpecFlow on our current process will keep me using it.

# Update

As expected, my ignorance didn't do StorEvil justice. From @[davidmfoley](http://twitter.com/#!/davidmfoley):

 ... StorEvil also has a R# runner and an MSBuild task
 http://bit.ly/cwryeB Just add StorEvil.TeamCity.DLL to your config (or the Assemblies setting if using the MSBuild task) gives you in-progress test results and trending/etc. reports in TeamCity

After talking with him and reading some more of the documentation, there aren't any reasons I can see to not give it a whirl.
