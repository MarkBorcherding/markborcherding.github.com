---
title: Package and Compress with Google Closure via MSBuild
layout: post
description: "Something really cool"
category:
tags: [ ]
---



<h1>The Problem</h1>  <p>So our problem is we are building a library of JavaScript files that we use all over the place. Ive been pushing, on the project where Im the sole developer, to wrote 99% of the JavaScript as jQuery plugins. This works great because we can compile that 99% into a single file, or to reverse the perspective, we can split that huge file into smaller, more manageable and logical files. </p>  <p>For example, we have a file called jquery.mycompany.core.js which does a variety of mundane tasks. The file is huge, but unlike C# code, its huge for a reason. We want the browser to make as few requests as possible so there is less handshaking, less overhead, and faster page loads. </p>  <p>Previously we had several files and we manually combine them to one and then run it through some online compressing tool once we get close to production. This <em>technically </em>worked, but changes found a way of making their way into the huge file and the segmented files become out of date and obsolete.</p>  <h1>The Hack</h1>  <p>So here was my plan, take a list of file, concatenate them, and then compress them. Simple enough right? Well, it actually isnt that bad</p>  <pre class="xml" name="code">  &lt;ItemGroup&gt;
    &lt;JavaScriptFiles  Include=&quot;scripts\jQueryPlugins\Custom\core\**\*.js&quot; /&gt;
  &lt;/ItemGroup&gt;

  &lt;Target Name=&quot;Default&quot; DependsOnTargets=&quot;BuildAndCompressOrdersJavaScript&quot;&gt;

  &lt;/Target&gt;

  &lt;Target Name=&quot;BuildAndCompressJavaScript&quot;&gt;
    &lt;ReadLinesFromFile File=&quot;%(JavaScriptFiles.Identity)&quot; &gt;
      &lt;Output
          TaskParameter=&quot;Lines&quot;
          ItemName=&quot;lines&quot;/&gt;
    &lt;/ReadLinesFromFile&gt;

    &lt;WriteLinesToFile File=&quot;scripts\jquery.mycompany.core.uncompressed.js&quot;
                      Lines=&quot;@(Lines)&quot;
                      Overwrite=&quot;true&quot; /&gt;


  &lt;/Target&gt;</pre>

<p>Not so bad right? Lastly, just add a bit of Google Closure. I just shell out and run it from the command line here.</p>

<pre class="xml" name="code">&lt;Exec Command='java -jar ..\compiler.jar --js scpts\jq.myco.core.un.js &gt; scpts\jq.myco.core.js' /&gt;</pre>

<p>I shortened some paths and filenames there so it would fit better in the blogs column, but you get the idea. </p>

<p>I threw this into a post build event even though I could have added it to the csproj directly. The post build event was easier and it avoids those nasty warnings when you open the csproj. </p>

<p>The only issue I see with it right now is it is not as portable as I would like it to be. You pretty much company and past the build steps if you need to use it again. This is my major gripe about MSBuild. Its difficult to create <em>functions</em> you repeat in the build. </p>

<p>This is a total cheapskate way to accomplish this task. I should be creating a nice parameterized MSBuild task, or even better, dump MSBuild for Rake. MSBuild and I acknowledge we are never going to be friends and have come to a professional arrangement. MSBuild does nothing to accommodate me and I do as little as possible with it.</p>
