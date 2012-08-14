---
title: Update on Beyond Compare inside Team Build and why I'm starting to hate TFS
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



In the past few days, and nights, I've learned a few things. Most are bummers, but there is light at the end of the tunnel. This is what I feel our build process was like for the past few days, but I think we're doing much better now and things are actually working. (Cross your fingers)

<object width="425" height="344" data="http://www.youtube.com/v/FdCJzO3w7_M&amp;hl=en&amp;fs=1" type="application/x-shockwave-flash"><param name="allowFullScreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="src" value="http://www.youtube.com/v/FdCJzO3w7_M&amp;hl=en&amp;fs=1" /><param name="allowfullscreen" value="true" /></object>

I've tried a few approaches yesterday and here is what I've found.

<h2>Deploying via Ftp</h2>
Initially, I tried to deploy to our servers via FTP. This appears to work well, but the timestamps are all adjusted by the GMT offset. In our case, the files end up on the server looking like they were edited 6 hours in the future. This makes every single file appear different on the next sync since none of the time stamps match. Apparently <a href="http://support.microsoft.com/kb/173054">this is by design from Microsoft</a>.  What a bummer. Running the development server on GMT will cause the timestamps in the database on that server to also be off.  This option is out.
<h2>Deploying via file share</h2>
Again, this appears to work well. The first time everything goes. We change a single file and the log sees that only one file has changed, but doesn't move it. <a href="http://en.wikipedia.org/wiki/Homer_simpson">Doh</a>! They come out of TFS as read-only, and copying to a file share will carry over those file attributes. No problem.

<code>attrib -r \\myServer\myShare\myApp\*.*</code>

Nope! You can't run <code>attrib</code> on a network share. It has to be a physical disk.

OK. Well I'll just <code>attrib -r</code> the source files in the build's working directory. Great! That worked. Let's try it again. Doh!

<code>Unable to perform the get operation because it is writable.</code>

<a title="Miedo by Arturo J. Paniagua, on Flickr" href="http://www.flickr.com/photos/elblogazo/13581318/"><img class="alignright" src="http://farm1.static.flickr.com/11/13581318_aa516390b9.jpg" alt="Miedo" width="320" height="241" /></a>

You're kidding me! Grr...OK! Fine! I'll <code>attrib +r</code> after I push. Nope! Not every file in the source directory is suppose to be read only and some of them <em>cannot</em> be read only. AHHH!

Oh yes! Beyond Compare has an <code>attrib -r</code> command in the scripting reference.
<blockquote>ATTRIB
Usage: attrib (+|-) [(+|-) &lt;...&gt;]

Sets (+) or clears (-) the DOS file attributes in the current selection.  An attribute set can include archive (a), system (s), hidden (h), and read only (r) attributes.   Windows only implementation: Linux version will not recognize ATTRIB.</blockquote>
Sound great right?....that doesn't work.  Even on simple unit test this doesn't work. I'm at my wit's end now. There is one more thing to try. There is one more command in the Beyond Compare script reference that might be able to help.
<blockquote>OPTION
Usage:
option stop-on-error
option confirm:(prompt|yes-to-all|no-to-all)

Adjusts script processing options.
 stop-on-error makes the script watch for various error conditions, including file operation errors, and, when one occurs, prompts the user before continuing.
 <strong>confirm can use prompt, yes-to-all, or no-to-all to handle confirmation dialogs that occur due to file operations.  By default, prompt is used. </strong></blockquote>
Let's hope this works. I'll put it right before the <code>sync</code>, cross our fingers and run it through some tests.

<strong>It WORKS!</strong> Or it appears to so far. Hopefully.  

The files on the server still carry the read only flag. That's not ideal for us, but it will have to do for now.
