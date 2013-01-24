---
title: ReSharper Tip of the Day -- Adding Usings and References 
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



When you go to use a type that is not added in the references, you can type out the complete name.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image002_2.jpg"><img style="border-width: 0px;" title="clip_image002" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image002_thumb.jpg" border="0" alt="clip_image002" width="332" height="100" /></a>

And ReSharper will know it needs to add, in this case, System to your using statements. Press <em>ALT + Enter</em> and it will add it for you.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image004_2.jpg"><img title="clip_image004" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image004_thumb.jpg" border="0" alt="clip_image004" width="331" height="92" /></a>

If the name is ambiguous it will ask which one you want.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image006_2.jpg"><img style="border-width: 0px;" title="clip_image006" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image006_thumb.jpg" border="0" alt="clip_image006" width="313" height="139" /></a>

If you dont even have the assembly referenced it will ask you to add that too.

<a href="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image008_2.jpg"><img style="border-width: 0px;" title="clip_image008" src="http://geekswithblogs.net/images/geekswithblogs_net/OntologicalReciprocity/WindowsLiveWriter/ReSharperTipoftheDayAddingUsingsandRefer_6E97/clip_image008_thumb.jpg" border="0" alt="clip_image008" width="449" height="206" /></a>

<strong>WARNING:</strong> This will make you lazy with remembering which assemblies and namespaces are home to which classes.
