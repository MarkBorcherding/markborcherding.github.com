---
title: Static Types Don't Fail Me Now
layout: post
description: "Something really cool"
category:
tags: [ ]
---



I'm really excited about using Cucumber. There has been a desire to get to that level of BDD-ish style tests ever since I first saw how readable they were. We're ready to make that next step. Let's pretend we have the following set of pages.

<a href="/wp-content/uploads/2010/05/mockup.png"><img src="/wp-content/uploads/2010/05/mockup.png" alt="" title="mockup" width="435" height="239" class="aligncenter size-full wp-image-946" /></a>

Pretty straight forward. We should be able to write a pretty simple Cucumber feature.

<pre name='code'>
Feature: Add Foos
  In order to keep track of foos
  As a person who enters foos
  I want to be able to add a foo

  Scenario: Adding a foo without searching
	Given I view the welcome page
	When I click the Add New Foo button
	Then I'm taken to the Add Foo page

  Scenario: Adding a Foo
    Given I've searched for a foo that doesn't exist
    When I click the "save" ...that should say "Add"
    Then I'm taken to the Add Foo page
</pre>

Simple enough. I'm not going to walk you through how to write the steps for that. I'm more interested in how you organize the pages into page modules inside a static language. In Ruby you could do something like
<pre name='code' class='ruby'>
class WelcomePage
  def intialize(browser)
    @browser = browser
    self.goto
  end

  def goto
  end

  def addFoo
    @browser.click '#add'
    AddFooPage.new(@browser)
  end

  def searchForFoo(query)
    @browser.type(query).into('#t') # made up syntax
    @browser.click '#b'
    SearchResultsPage.new(@browser)
  end

end

class SearchResultsPaage
  def initialize(browser)
    @browser = browser
  end
  def addFoo
    @browser.click '#add'
  end
end
</pre>

That isn't WatiR. It's totally made up. I'm a Ruby Newby too so told shoot me for any syntax errors.

You can drive it with something like this.

<pre name='code' class='ruby'>
Given /I view the welcome page/ do
  @page = WelcomePage.new(browser)
end

Given /I search for (.*)/ do |q|
  @page = page.searchFor(q)
end

Given /I click on the add button/ do
  @page = page.addFoo()
end
</pre>

Pretty straight forward huh? Well how I do that in C#? All of those Navigate methods will either return a specific page type or a base type that will make it impossible to call the subsequent specific steps.

<pre name='code' class='c#'>
public class WelcomePage{
  public SearchResultsPage SearchFor(query){
    _browser.Type(query).into('#q');
    _browser.Click('#btn');
    return new SearchResultsPage(_browser);
  }
}

public class SearchResultsPage{
  public AddFooPage AddFoo(){
    return new AddFooPage(_browser);
  }
}
</pre>

Then drive it with this.

<pre name='code' class='c#'>
var welcome = new WelcomePage(_browser);
var results = welcome.SearchFor('bar');
var add = results.AddFoo();
</pre>

Doesn't that feel messy? Luckily, I think a feature of .Net 4.0 might save the day!

<pre name='code' class='c#'>
dynamic page = new WelcomePage(_browser);
page = page.SearchFor('bar');
page = page.AddFoo();
</pre>

Three cheers for dynamic!
