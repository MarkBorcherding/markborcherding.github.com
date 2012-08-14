---
title: Personal Branches with Git
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Quite often I find myself wanting to experiment with something with whatever I'm working on. I want to roll back to the point I'm at now if it doesn't workout, but I don't want to commit what I've started to the shared source repository for everyone else to see just yet. So what is one to do? Comment out a whole heck of code and manually rollback if I need to? That's a bummer. 

If we're using TFS (we currently are) you can create a shelveset of the current point and unshelve it later if you need to. That isn't a terrible option, but I would really like to be able to check in often and compare between my current point and previous versions. 

Enter <a href="http://git-scm.com/">Git</a>. I've been hearing a lot of hype about Git, but never really found a need to have the entire repository on my local box...until I thought about what a personal branch would need. It would need exactly that. Anyway, this is not a novel idea. You can search the Google for exactly this and there are ton of articles describing how to make it work.  

What I was most amazed with was how easy it was to get Git setup and how fast the operations were. It's amazing how fast operations can be if you are smart about what you're doing and don't rely on the server to do everything. (TFS, please take that as an insult.) 

So skipping the install of <a href="http://code.google.com/p/msysgit/">msysgit</a>, you can have your repository setup in no time. It is really as simple as:

<pre>
cd \my\source\dir
git init
</pre>

You have files in that directory you want to track
<pre>
git add .
</pre>

Ready to check in your changes?

<pre>
git commit -m "some message"
</pre>

OK. Now you've made changes and want to rollback?

<pre>
git checkout .
</pre>

Now you want to try out a new branch for a while?

<pre>
git branch newbranch
git checkout newbranch
</pre>

Ready to go back to the main branch?

<pre>
git checkout master
</pre>

Pretty amazing huh? It is really that easy. I've included a screencast of a similar set of steps to those so you can see it really is that easy. It's nothing flashy, but it really shows how easy it is to get setup.

<embed width="700" height="300" type="application/x-shockwave-flash" src="http://v5.tinypic.com/player.swf?file=a3hvmo&s=5"><br><font size="1"><a href="http://tinypic.com/player.php?v=a3hvmo&s=5">Original Video</a> - More videos at <a href="http://tinypic.com">TinyPic</a></font>

There is a GUI tool that gets installed and <a href="http://code.google.com/p/tortoisegit/">some</a> <a href="http://sourceforge.net/projects/gitextensions/">extensions</a> to make things a little easier. 

Just remember if you ever need help from the command line, help is right around the corner.

<pre>
git help checkout
</pre>
