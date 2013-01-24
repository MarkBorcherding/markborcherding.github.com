---
title: Automating the Build (Step 1)
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



We are starting to automate and standardize our build process. I think the idea that <a href="http://www.codinghorror.com/blog/archives/000988.html">F5 is not a a build strategy</a> is finally surfacing as a real problem. The first step in my mind is to come to some convention on the structure. Doing so would make configuration a lot simpler. We can default the convention and you can overwrite if you feel the need.

Microsoft has some <a href="http://www.codeplex.com/TFSGuide/Wiki/View.aspx?title=Chapter%204%20-%20Structuring%20Projects%20and%20Solutions%20in%20Team%20Foundation%20Source%20Control&amp;referringTitle=Home">guidance</a> on the subject of how to structure the source when using TFS. I'm not really sure how the choice of source control factors into that decision, but we'll just go with it. The structure I'm playing with now is very similar to their recommendation.
<pre name="code" language="">
/Fooberry/
          1.0.0/  &lt;-- the build file goes here
                docs/
                source/
                       application/ &lt;-- the source for the ui
                       application.tests/ &lt;-- the UI tests
                       core/
                       core.tests/
                       ...I'm not settled on how this level
                          will look. It isn't important for
                          now. I'm more concerned with the
                          files needed to build.
                libs/
                    my.company.build/
                    msbuild.community.tasks/
                    nunit/
                    nxslt/
                    nunit4teambuild/
                    n*...all shared libs and tools
               ...maybe some other dirs here eventually
          main/ &lt;-- the trunk copy just like the 1.0.0 tree
/SomeOtherApp/</pre>
The main point here is that all the tools we use are inside the source control for every app and every branch of that app. It may seem like a waste of disk space, but what it allows is all configuration information to be relative to the build root. A specific branch can upgrade to a new NUnit and all the other builds don't need to worry about backwards computability.

A folder that may look a little odd is <code>my.company.build</code>. I would like this folder to hold as much of the automated build extensions as possible. There are going to be a few additional steps that we need to add to the out of the box <code>TFSBuild.proj.</code> The plan is to put all the new targets in a <code>my.company.build.targets</code> file along with any custom tasks that we need to build. Once we have that, we can stick the following line into the <code>TFSBuild.proj</code> and we snap on all our custom steps.
<pre name="code" language="xml">
&lt;Import Project="$(SolutionRoot)\libs\my.company\my.company.build.targets"/&gt;
</pre>
Getting the import setup was a little bit of pain. Running locally, <code>$(SolutionRoot)</code> doesn't map to the correct path. The path to the targets file was mapping someplace crazy. This has a really bad smell, but I was overjoyed that it worked remotely, so I didn't care too much for now. It's only day one. We will need to build locally eventually. That's on the TODO list already.

I have a bit of a confession. I wish that was the manner in which I started this process, but I didn't realize that we could externalize the build steps to <code>my.company.build</code> until after I started filling out the steps. This is is how, in my opinion, frameworks are most successfully built. We extract the code that could be made common instead of head out to write something that will solve everyone's problem, even though you don't know what their problem might be.

So to start on the first build step; running NUnit tests. After a quick Google search,
<a href="http://www.codeplex.com/nunit4teambuild"> Nunit4TeamBuild</a> on CodePlex outlined the steps we needed to take.
<blockquote>
<ol>
	<li>Run Nunit-console and produce an XML log file</li>
	<li>Convert the Nunit XML output to an MSTest test results file (with a .trx extension)</li>
<li>	<li>Use MSTest /publish to push merge the trx file with an existing build</li>
</blockquote>
Sounds pretty straight forward. There are a few more dependancies. It uses the <a href="http://msbuildtasks.tigris.org/">MSBuild Community Tasks</a> and <a href="http://www.xmllab.net/Products/nxslt2/tabid/73/Default.aspx">nxslt2</a> (There is a new nxslt3 which uses .Net 3.5...not sure what that gains us though).

The documentation for Nunit4TeamBuild recommends adding an AfterCompile target to execute the NUnit tests. We can put this in our <code>my.company.build.targets</code> file. There are just a few housekeeping items first. The example proj file has hard coded paths to the MSBuild Commnuity Tasks, NUnit and NXslt. To make those relative, assign the....
<pre name="code" language="xml">&lt;PropertyGroup&gt;
   &lt;MSBuildCommunityTasksPath&gt;$(SolutionRoot)\libs\community.msbuild.tasks\&lt;/MSBuildCommunityTasksPath&gt;
   &lt;NUnitPath&gt;$(SolutionRoot)\libs\nunit\&lt;/NUnitPath&gt;
&lt;/PropertyGroup&gt;

&lt;Import Project="$(MSBuildCommunityTasksPath)\MSBuild.Community.Tasks.Targets"/&gt;</pre>
When we go to invoke the NUnit task, we need to be sure and give the ToolPath of $(NUnitPath).
<pre name="code" language="xml">&lt;NUnit ContinueOnError   = "true'
        Assemblies       = "@(TestAssemblies)"
        OutputXmlFile    = "$(OutDir)nunit_results.xml"
        ToolPath         = "$(NUnitPath)"&gt;
   &lt;Output TaskParameter = "ExitCode"
           PropertyName  = "NUnitResult" /&gt;
 &lt;/NUnit&gt;</pre>
*Note: I'm playing with the formatting of the XML. I'm trying out this style for now.

So that takes care of the NUnit and the MSBuild Community Tasks. The next tool that needs a relative path is NXslt. The example project shows invoking the command line executable via the Exec task.

<pre name="code" language="xml">&lt;Exec Command="C:\path\to\nxslt\nxslt2.exe &amp;quot;$(OutDir)nunit_results.xml&amp;quot; &amp;quot;$(SolutionRoot)\nunit transform.xslt&amp;quot; -o &amp;quot;$(OutDir)nunit_results.trx&amp;quot;"/&gt;
</pre>

While that works, NXslt comes bundled with an <a href="http://www.xmllab.net/Products/NxsltTask/tabid/184/Default.aspx">MSBuild task</a> that can replace it with something more elegant. To use the task, add the Using

<pre name="code" language="xml"> &lt;UsingTask AssemblyFile = "$(NXsltTaskAssembly)"
            TaskName     = "Nxslt" /&gt;
</pre>

And replace that Exec with the following:

<pre name="code" language="xml">  
&lt;Nxslt In    = "$(OutDir)nunit_results.xml"
         Style = "$(SolutionRoot)\libs\nunit4teambuild\nunit transform.xslt"
         Out   = "$(OutDir)nunit_results.trx" /&gt;
</pre>

One more to go. MSTest.exe is invoked to publish the newly formatted results. This one might be more difficult to keep relative. Right now, this is pointing (or trying to point) to the MSTest.exe under Program Files. With all that said, I'm unable to find where MSTest is on the build server. Having no access to it makes it a little difficult. Unfortunately I cannot guarantee that the final step will actually work. I hope to have <a href="/2008/09/09/automating-the-build-step-1-contd/">more news</a> to report next week.
