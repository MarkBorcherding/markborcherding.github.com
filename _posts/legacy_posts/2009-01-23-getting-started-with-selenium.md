---
title: Getting Started with Selenium
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



The past few days have been spent getting<a id="j.c:" title="Selenium" href="http://seleniumhq.org/">Selenium</a> setup and running as part of our CI builds. We only have a few proof-of-concept tests right now, but the power and potential is apparent. We have no automated unit testing right now and very little code in our code behinds so functional testing is as good as we're going to get. Also, with the amount of AJAX that is currently in our pages, and the additional amount we see in them in the near future, Selenium's method of control the browser helps us make sure our pages do and continue to behave like we expect.

Getting setup with Selenium was incredibly simple. The Selenium IDE Firefox plugin makes creating your first Selenium test a snap. Download it and install it and you're off. I'm not going to walk you through creating the tests, because the Selenium web site has a pretty decent<a id="em17" title="movie" href="http://seleniumhq.org/movies/intro.mov">movie</a> that'll take care of you.

The output of the test recorder are HTML files that contain the instructions, aka "Selenese", to re-execute the tests through both the IDE and Selenium core. Selenese is very simple<a id="fuos" title="by design" href="http://darkforge.blogspot.com/2006/12/why-is-html-selenese-so-simplistic.html">by design</a>. While we could run the Selenese tests through the core in our ContinuousIntegrationserver, I've decided to use the IDE to export the C# source for the tests I create. This allows my to put the Selenium test into an NUnit test harness, refactor some of the common setup and config, and also run the tests via<a id="d7yk" title="Selenium Remote Control" href="http://seleniumhq.org/projects/remote-control/">Selenium Remote Control</a>(RC). I know the refactoring goes against the Selenese simplicity, but I want to run my tests locally and with different credentials without changing every test. Also, running in RC lets me run the tests without having to watch the pages in the browser fly by and, someone day, concurrently run all the browsers I care about.

Here's an example of what one of those tests might look like
<pre language="c#" name="code">
using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using NUnit.Framework;
using Selenium;

namespace SeleniumTests{

   [TestFixture] public class NewTest {
	private ISelenium selenium;
	private StringBuilder verificationErrors;

	[SetUp] public void SetupTest() {
		selenium = new DefaultSelenium("localhost", 4444, "*chrome", "http://www.google.com/");
		selenium.Start();
		verificationErrors = new StringBuilder();
	}

	[TearDown] public void TeardownTest() {
		try {
			selenium.Stop();
		} catch (Exception) {
			// Ignore errors if unable to close the browser
		}
		Assert.AreEqual("", verificationErrors.ToString());
	}

	[Test] public void TheNewTest() {
		selenium.Open("/");
		selenium.Type("q", "fooberry");
		selenium.Click("btnG");
		selenium.WaitForPageToLoad("30000");
	      Assert.IsTrue(selenium.IsElementPresent("css=a[href=\"http://www.fooberry.com/\"]"));
	}
   }
}
</pre>
Getting this to run in the Team Build is as easy as<a id="dglw" title="getting the regular NUnit tests running" href="/2008/09/05/automating-the-build-step-1/">getting the regular NUnit tests running</a>. First we would want to parameterize those tests a bit so we can pass different hosts, ports and credentials (if present). That's not too hard and should be obvious.

We're trying multiple CI builds. One build just compiles and runs the unit test code, which is currently this single test....baby steps.
<pre language="c#" name="code">
[TestFixture] public class TheMostAwesomestUnitTestInTheWorld {
    [Test] public void ValidateOurCoreBeliefs() {
        Assert.That(true, Is.True);
    }
}</pre>


The other build compiles and runs both the unit tests and integration tests. We suspect this build will take a while and the sooner we could get feedback about the quality of the build, the better. We could push this build to a separate build agent too, but for right now they are all just backing up in the same queue.

The only missing piece of the puzzle so far is the Remote Control Server. The RC Server is a Java application that has to run on a machine with access to which ever browser you plan to test. Starting the server is simple enough. Just make sure Firefox.exe is in the path. If you forget, you'll get a nice warning about it.

<pre name="code">java -jar selenium-server.jar</pre>

It's up an running and when you run the above unit test, you see the browser window fly by and the server log all the actions it's performing on the browser. 

Great! ...if you want to stay logged into your server with the console open, but I didn't. Luckily, creating a Windows service is pretty easy. There is a great tutorial out there that walks you through <a href="http://fitnesse.org/InstallingFitNesseAsaService">how to setup a similar Java application as a service</a>. Just substitute the Selenium RC Server for the FitNesse server. Note that when I tried to install the Windows Server 2003 Resource Kit, on both Vista and Windows Server 2008, I got a compatibility warning. I ignored the warning since I was only using the two files and it worked great.

Now you can start and stop the Selenium RC Server via a Windows service, keep it running when you log out and start automatically when the server starts up. 

Have fun.
