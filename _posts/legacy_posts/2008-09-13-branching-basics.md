---
title: Branching Basics
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



A friend at work asked me to describe the branching strategies we use on our team. Our organization is moving to Team Foundation Server from Visual Source Safe and people are starting to have a lot more confidence in branching their code. First, I wanted to go over the basics of branching and why working without isolation can, and have, caused so many headaches.

The most basic utilization of source control is to commit your changes and, hopefully, label the project for each release to your customers. You gain both the history of how the source has changed overtime and configuration information about how the source looked at the time of each release.
<p style="text-align: center;"><img class="size-full wp-image-335 aligncenter" title="blog001-trans" src="/wp-content/uploads/2008/09/blog001-trans.png" alt="" width="500" height="113" /></p>

For applications with no new development, only service packs or maintenance releases, this works fine. There is little need to have concurrent development and therefore isolation of that development. Where this method becomes problematic is when deep into new development of the next version, you need to fix a bug in the version(s) youve already released.

If you dont have the labels youll have a tough time resurrecting the source that was built in the previous release(s). Assuming you can identify the source in the previous build, you have a few options on how to apply the patch. If you are patching the most recent version you could comment out all the new features that arent ready to go to production, apply the patch to the main source, label and release the service pack. Then you would uncomment out the code and keep going on new development. This could be a large amount of tedious work. If the deltas that need to roll back are small this might not be a bad option, but in most cases it is just a headache.

The next simplest alternative is to rollback the source the to release label, copy the entire source tree, patch, label, and release. This does provide the isolation we desire and allows new development to continue without impact from the service pack, but now you are presented with a new challenge. You must get the changes from the service pack back to the main source. This will be very manual process where you will look at the files in each source tree, determine which has been changed, and apply the deltas to the main source tree. Not as bad as the other method, but it would be nice if we could maintain that relationship and get some help with bringing our changes back to the main source.

Enter branching. Branching appears to do exactly what we did when we copied the source. It does some fancy magic under the covers, but we can ignore that for now. It will create an isolated branch of the source that we can commit changes to free of worries of introducing new development to the service pack, or service pack code to the new development until it is complete.
<p style="text-align: center;"><img class="size-full wp-image-339 aligncenter" title="blog003-trans" src="/wp-content/uploads/2008/09/blog003-trans.png" alt="" width="500" height="256" /></p>

Branches maintain that logical relationship which provide a huge advantage when it comes time to merge our changes back. At the time of the merge our tools can look at the histories of both the source and target branch and determine if code is being added, removed or changed. It will <a href="http://en.wikipedia.org/wiki/Alton_Brown">thusly</a> apply the changes, but in some cases changes will exist to the same part of code in both places. This needs to be resolved manually.
<p style="text-align: center;"><img class="size-full wp-image-338 aligncenter" title="blog002-trans" src="/wp-content/uploads/2008/09/blog002-trans.png" alt="" width="500" height="248" /></p>

<strong>While the merge is usually very smart, especially if the branch hasnt diverted very far from the source, this doesnt mean the source is free from errors.</strong> It is possible for one class to change in the branch and the other to change in the trunk and when merged back, no conflicting changes are found, but the classes dont cooperate like that should.

The merge is more than a one way operation. In addition to merging from the branch back to the source of the branch, changes can be merge to the branch. This is useful if a bug fix was already patched in the new development branch and needs to be included in a service pack release.
<p style="text-align: center;"><img class="size-full wp-image-340 aligncenter" title="blog004-trans" src="/wp-content/uploads/2008/09/blog004-trans.png" alt="" width="500" height="266" /></p>

That covers the very basics of branching and merging. Ill be back in a bit to explain the strategies our team implements.
