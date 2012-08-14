---
title: TFS, Team Build, and Beyond Compare as a lighter XCopy
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



We're using TFS 2008 and Team Build to compile and build a website mixed with ASP.Net and classic ASP. It works fine, but the only problem is the site is huge. It's over over 2500 files and over 400 megs. That's HUGE! We <em>could</em> XCopy that to our server, but pushing 400 megs every time feels like a little bit of overkill, especially when the majority of the changes are copy updates. We could also use a content management system for this, but we thought we would give try it with TFS.

First, it took forever to pull 400 megs out of source control every time we did a build. We can fix that.
<pre name="code" language="xml">&lt;PropertyGroup&gt;
    &lt;IncrementalGet&gt;true&lt;/IncrementalGet&gt;
&lt;PropertyGroup&gt;</pre>
Done. Now the build will only pull down the files that changed. It'll leave the files from previous build laying around on the server, but that's OK.

Next, it takes forever to copy the 400 megs to the drop folder.  We don't even need to do it in the first place since we are going to xcopy the _PublishedWebsites contents elsewhere when we're done. We can fix this problem with ease too.
<pre name="code" language="xml" >&lt;PropertyGroup&gt;
    &lt;SkipDropBuild&gt;true&lt;/SkipDropBuild&gt;
&lt;PropertyGroup&gt;</pre>
Now we won't copy the build to the drop server.

So finally the XCopy. That was a little more tricky. We need to figure out only the files that change and transfer them, via FTP in out case. Luckily, Beyond Compare not only has a scripting interface that will let us work it into the build script, <strong>it also has the example script of how to do exactly what we want to do in the documentation</strong>. Win for us!

We can just tweak it a bit and we're off to the races. Let's make a script file called deploy.to.server.script and put it in the same folder as the TFSBuild.proj.
<pre name="code" language="ruby" ># %1 is source of the build to copy to the new server
# %2 is the outdir where the log should be written

#log the script actions
log verbose "%2\deployment.log.txt"

#set the comparison criteria
criteria timestamp size

#load source and target
# you could also use a UNC share
load "%1" "ftp://user:password@oursite.com"

# Move everything
filter "*.*"

#Sync the local files to the web site, creating empty folders
sync create-empty mirror:lt-&gt;rt</pre>
Next, invoke it in the build script.
<pre name="code" language="xml" >&lt;Exec
 Command="&amp;quot;c:\Program Files\Beyond Compare 3\bcompare.exe"
 &amp;quot;@$(MSBuildProjectDirectory)\deploy.to.server.script&amp;quot;
&amp;quot;$(SolutionRoot)\MyWebsite" &amp;quot;$(OutDir)&amp;quot;  \silent \closescript" &gt;</pre>
We're done. It'll only copy the stuff we've changed and we've taken our build time from 25 minutes down to less than one.

<strong>Update:<strong> If you want to keep an eye on what you're moving, add the following steps in the Beyond Compare script.</strong></strong>

<strong><strong>
<pre name="code" language="ruby" >#load source and target
# you could also use a UNC share
load "%1" "ftp://user:password@oursite.com"

expand all
folder-report &amp;
    layout:side-by-side &amp;
    options:display-mismatches &amp;
    title:"Deployment Report" &amp;
    output-to:"%2\deployment.summary.html" &amp;
    output-options:html-color</pre>
Sorry about the funny syntax highlighting. There is not "BeyondCompare" language available.

You'll get a nice HTML report.
<img class="alignnone size-full wp-image-611" title="ss-20090129092919" src="/wp-content/uploads/2009/01/ss-20090129092919.png" alt="ss-20090129092919" width="726" height="306" />

<strong>Another Update:</strong> It looks like <a href="http://www.scootersoftware.com/vbulletin/showthread.php?t=3753">Beyond Compare will <em>not</em> tell you if an error occurs during the script</a>. This is a huge bummer. If you get something like this in your script, it'll still return 0 for the ExitCode and you won't know it failed.
<pre>1/29/2009 11:40:42 AM  Fatal Scripting Error: Unable to load base folder
1/29/2009 11:40:42 AM  Script completed in 0.01 seconds</pre>
<strong>Yet another update:</strong> There is some <a href="/2009/01/30/update-on-beyond-compare-inside-team-build-and-why-im-starting-to-hate-tfs/">new news</a> on using Beyond Compare with Team Build.

</strong></strong>

<strong>One more update:</strong> Here is a copy of the edit to the <code>TFSBuild.proj</code> file. This gets added at the end of the file before the closing <code>&lt;Project></code> tag.

<pre language="xml" name="code">
 	&lt;PropertyGroup>
		&lt;IncrementalGet>true&lt;/IncrementalGet>
	&lt;/PropertyGroup>

	&lt;!-- Since we are doing the source side by side we deploy before 
		copying to the the builds folder. We might consider changing this
		to AfterDropBuild and copy from there if we are doing the precompiled
		websites -->
	&lt;Target Name="BeforeDropBuild">
		&lt;CallTarget Targets="Deploy"/>     
	&lt;/Target>


	&lt;Target Name="Deploy">
		&lt;!-- Create a Custom Build Step -->
		&lt;BuildStep 
			TeamFoundationServerUrl="$(TeamFoundationServerUrl)" 
			BuildUri="$(BuildUri)" 
			Name="BeyondCompareDeployStep" 
			Message="Deploying to webserver">
			&lt;Output 
				TaskParameter="Id" 
				PropertyName="BeyondCompareDeployStepID" />
		&lt;/BuildStep>

		&lt;!-- We are deploying the source side by side with the pages instead of 
			doing the precompiled website-->
		&lt;Exec Command="&amp;quot;c:\Program Files\Beyond Compare 3\bcompare.exe&amp;quot; &amp;quot;@$(MSBuildProjectDirectory)\deploy.to.server.script&quot; &amp;quot;$(SolutionRoot)\source&amp;quot;  &amp;quot;\\myWebserver\path\to\mysite&amp;quot;  &amp;quot;$(DropLocation)\$(BuildNumber)&amp;quot;  \silent \closescript" >
			&lt;Output 
				TaskParameter="ExitCode" 
				PropertyName="BeyondCompareExitCode" />
		&lt;/Exec>

		&lt;!-- These tests don't work as BeyondCompare will ALWAYS exit with code 0 from script -->
		&lt;BuildStep 
			Condition="'$(BeyondCompareExitCode)' == '0'" 
			TeamFoundationServerUrl="$(TeamFoundationServerUrl)" 
			BuildUri="$(BuildUri)" 
			Id="$(BeyondCompareDeployStepID)" 
			Status="Succeeded"/>
		&lt;BuildStep 
			Condition="'$(BeyondCompareExitCode)' != '0'" 
			TeamFoundationServerUrl="$(TeamFoundationServerUrl)" 
			BuildUri="$(BuildUri)" 
			Id="$(BeyondCompareDeployStepID)" 
			Status="Failed"/>		
		&lt;Error 
			Condition="'$(BeyondCompareExitCode)'!='0'"  
			Text="Deployment Failed" />
	&lt;/Target>
</pre>

The olny other file is the <code>deploy.to.server.script</code> file. This file sits aside the <code>TFSBuild.proj</code> file and looks like this.
<pre language="ruby" name="code">
# %1 is the solution root of the build
# %2 is the target location (ftp or share) to deploy
# %3 is the outdir where the log should be written

#log the script
log verbose "%3\deployment.log.txt"

#set the comparison criteria
criteria timestamp size

#load source and target
load "%1"  "%2"

expand all 
folder-report &
    layout:side-by-side &
    options:display-mismatches &
    title:"Deployment Report" &
    output-to:"%3\deployment.summary.html" &
    output-options:html-color

filter "*.*"

# we want to override all the read-only files that exist
option confirm:yes-to-all

#Sync the local files to the web site, creating empty folders
sync create-empty mirror:lt->rt
</pre>
