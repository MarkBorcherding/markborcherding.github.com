---
title: Resetting Team Build IncrementalGet Builds
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>After tinkering around with file attributes in our builds working folder, I needed wipe the entire working directory and start with a fresh set of source. Just deleting the working directory isnt good enough if youre using incremental gets.</p>  <p>The build must store the most recent changeset its built and only get changesets that are greater than its current. If you try and just delete the working directory and build youll get the following error.</p>  <blockquote><code>error MSB3202: The project file &quot;whatever.sln&quot; was not found.</code> </blockquote>  <p>To tell the build not to do an incremental build on this one single build in the queue, add the following property to the Queue Build window.</p>  <p><a href="/wp-content/uploads/2009/01/image3.png"><img title="image" style="border-right: 0px; border-top: 0px; display: block; float: none; margin-left: auto; border-left: 0px; margin-right: auto; border-bottom: 0px" height="490" alt="image" src="/wp-content/uploads/2009/01/image-thumb3.png" width="437" border="0" /></a></p>
