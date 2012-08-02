---
title: Missing PKs and LINQ to SQL
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p><a href="http://www.flickr.com/photos/blakewest/3084965561/"><img style="margin: 0px 0px 0px 5px; display: inline" align="right" src="http://farm4.static.flickr.com/3204/3084965561_e64644e3b4_m.jpg" /></a>Lets say you were designing a tool to generate code from a diagram. If you were try to generate code for a situation where you expect there to be a primary key on a table, and there isnt, would you:</p>  <p> a) assume you dont need the PK and work around it. </p>  <p>b) throw an error dialog to the screen with a nice error message</p>  <p>c) just skip generating the functionality they were expecting and go on like they really never needed it</p>  <p>If you were the LINQ to SQL team, you would have picked c. I realize tables need PKs and that trying to find an row when there is no PK might be a tad difficult, but at the same time a little help would be nice. A simple dialog No PK found on table Moron would have been all I needed.</p>
