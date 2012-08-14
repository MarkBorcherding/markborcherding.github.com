---
title: Branching Strategies
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



With a understanding of the basic <a href="/2008/09/13/branching-basics/">concept of branching</a>, we can cover the branching strategies my team uses and the level of success we've been able to achieve with each.


<h2>Never Branch</h2>
Honestly, most of our applications do not branch at all. Most of the applications our team maintains have were developed in Visual Basic 6 and stored in Visual Source Safe repositories a decade ago. We do very little maintenance development on them and no new development. We receive a bug, patch and deploy one or two bugs at a time so there is little need for extra overhead created by branching.
<p style="text-align: center;"><img class="aligncenter" src="/wp-content/uploads/2008/09/blog001-trans.png" alt="Blog.001 Trans" width="594" height="133" /></p>

<h2>Branch for Maintenance</h2>
While we have no applications that follow this method, I feel compelled to mention the simplest method of creating isolation via branching. While continuing development down a single path, as we do with our VB6 application, a large development effort maybe underway and the need to patch the existing version arises. In this case we could create a branch from the label of the previous release, patch, release and merge the patch back to the main path. This was the method of branching mentioned in the previous post.
<p style="text-align: center;"><img class="aligncenter" src="/wp-content/uploads/2008/09/blog005-trans.png" alt="Blog.005 Trans" width="635" height="165" /></p>

It is commonly called "Branch for Maintenance" because you branch at the time you <em>need</em> to apply maintenance to and existing piece of software. The reasons we don't use this method on our team will be highlighted.
<h2>Branch for Version</h2>
On my current project we have our main source tree or "<a title="Trunk (software) - Wikipedia, the free encyclopedia" href="http://en.wikipedia.org/wiki/Trunk_(software)">trunk</a>"; however, we don't develop against it. Our project has a predictable release schedule with a known set of bugs and enhancements that are to be included in each of these releases. We create a branch for each version we plan to release and commit all changes to that branch. This includes branching for any service pack version(s) we plan on releasing.
<p style="text-align: center;"><img class="aligncenter" src="/wp-content/uploads/2008/09/blog006-trans.png" alt="Blog.006 Trans" width="635" height="258" /></p>

The branch allows us to concurrently work on multiple future versions and service packs. This is very valuable during the end of iteration when the app can spend several days, or even weeks, in user acceptance testing. During this time, while the app under user acceptance testing is frozen for new development, the next release can be under heavy development in its own branch. If issues during user acceptance need to be resolved, those patches can be applied to the tip of that version's branch, and the next version is unaffected until the merge occurs.

We've found that as the date to branch the next version approaches, it pays to start merging back to the trunk. This will let the future branch start closer to its previous version. The closer the versions are at the start the fewer merges happen once the final merge is completed.

Some bugs cannot wait for the next release schedule. These bugs get their own service pack release and their own branch. Instead of being branched form the trunk, which may contain changes from other versions, the branch is created from the tip of the released version's branch. This ensures that the start of the service pack branch is the exact source that is running in production. Once the patch is created, committed and released, we merge those changes back to the trunk and back down to any branches for future versions that might need the bug fix as well.

In addition to working from the branch, we create a build for each branch that will deploy the tip of the branch to the our development and testing environments. This is valuable in that the version in each environment can be switched with ease. We run the build for the version we need, it builds it from its branch and moves it to the correct servers. We can also take our servers back to previous versions if we want to recreate a production bug in a more transparent environment.

The benefits of this branching strategy outweighs the overhead created by the resulting merges. In most cases our merges are very straight foreword.
<h2>Branch for Feature</h2>
The last strategy we've only discussed using on our team, and actually haven't implemented yet. Before we get into the actual method, an overview of the situation's issues may help clarify our intended benefits.

One of our applications has several features and bugs being worked on at the same time by several people. In order to get the features and bug fixes to the users as quickly as possible the release schedule depends heavily on when the bugs can be fixed first. Once a high priority feature is completed, the app needs to go production. This means other feature and/or bug fixes may, or may not get included in the next release. Also, on some occasions a production issue comes in and needs to be fixed right away, before anything else goes to production.

As you can imagine, this is a nightmare to keep straight. There were two options for keeping unwanted code from making its way to production. Just as without branching, we could open up the code and comment out the code that<em> can't </em>go, and then immediately uncomment it once the application releases. What we found was people were afraid to commit <em>any</em> changes to source control until their feature or bug fix was complete to avoid that nightmare. It could take a couple weeks to complete their feature and this means a couple weeks between commits of the code. Again, not something we desire. We want to integrate the changes sooner than a couple weeks.

What we are trying now is to create branches for each of the features/patches under development. Once they are complete we merge the branch back to the trunk. We then build and release from the trunk. This method allows us to pick which features that will be included in the next version. It lets us maintain history as the features develop since commits to the feature's branch are isolated from other features.
<p style="text-align: center;"><img class="aligncenter" src="/wp-content/uploads/2008/09/blog007-trans.png" alt="Blog.007 Trans" width="646" height="284" /></p>

This method is only valuable because of the unpredictable schedule and chaotic combination of features included in each release. It <em>does</em> create more overhead than branch for version since there can potentially be numerous branches all being developed concurrently.  This means more merges and potentially more conflicts.
<h2>Branch Housekeeping</h2>
<h3>Source Structure</h3>
We struggled with where to store all these branches. We've settled on storing them closer to the trunks than we did initially. Here is an example of what our source tree currently looks like:
<pre>/MyApp/main/docs
           /libs
           /release.scripts
           /source/core
                  /core.unitTest
                  /domain
                  /domain.unitTests
                  /...etc
           /...etc
      /1.0/docs
          /libs
          /...etc
      /1.1/docs
          /libs
          /...etc
      /2.0/docs
          /libs
          /...etc</pre>
The directory <var>libs</var> is a directory to store our third party and external libraries used by the application. This directory is branched along with the source. This allows for different releases to use different versions of the same dependencies. The ultimate goal is to have <em>everything</em> needed to build the application under the <code>main</code> or branch directory. This includes all documentation and all scripts needed to setup the database. If we were really cool we would be able to have the build scripts setup the database based on the scripts in its branch, but we're not that cool.
<h3>Building the Branch</h3>
To build each branch in the <em>Branch for Version</em> we create a build that we can instigate either by check in or manually. Be careful; <strong>if the build actually deploys to the build servers, only one build should be instigated by a check in</strong>. You wouldn't want the version on the server changing depending on what was the last branch to get a commit. That's not to say the build can't happen to validate the tests still pass, but just don't deploy to the server.

In our build tool you would see builds like:
<ul>
	<li>MyApp - 1.0</li>
	<li>MyApp - 1.1</li>
	<li>MyApp - 2.0</li>
</ul>
It works really well. With a button click we can put the next version on the development servers to illicit feedback on features in development and turn around and replace it with the version under user acceptance testing.
