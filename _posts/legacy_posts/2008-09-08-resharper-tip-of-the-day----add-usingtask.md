---
title: ReSharper Tip of the Day -- Add UsingTask
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



While working in an MSBuild file I notice ReSharper will help you out with using new tasks. If you use one it doesn't know, it'll offer to add its UsingTask statement to reference it.

<img class="alignnone size-full wp-image-328" title="add_usingtask_1" src="/wp-content/uploads/2008/09/add_usingtask_1.jpg" alt="" width="292" height="169" />

It'll throw this in at the top of the document.

<pre language="xml" name="code">
&lt;UsingTask TaskName="Fooberry" AssemblyName=""/&gt;&gt;
</pre>
