---
title: TFS, Team Build and a Build Confirmation
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>We recently wanted to add a manual verification to our TFS builds. We didnt want someone accidentally clicking the build to production when they meant to build to development. They are right next to one another and look very similar. </p>
<p>I didnt want to spend a lot of time on it, so I came up with this. Itll work for now and ensure we manually interact with the queue build dialog. </p>
<pre name="code" class="xml">
&lt;Target Name="BeforeEndToEndIteration" Condition="'$(C***)' != 'suck'" >
    &lt;Error Text=
"You did not state your feelings for the C***. Please state this by submitting
 the parameter /p:C***='suck' in the queue build dialog."/>
&lt;/Target>
</pre>
<p>The parameter name realy isn't "C***", but I didn't want to offend any followers of the team with the longest championship drought of any professional sports team. Actually, I bet it is safe to extend that to individual performers too. </p>
