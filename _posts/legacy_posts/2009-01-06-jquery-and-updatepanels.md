---
title: jQuery and UpdatePanels
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



While using a jQuery plugin to round corners, they started to disappear inside UpdatePanel's after a partial post back. I found <a href="http://stackoverflow.com/questions/256195/jquery-documentready-and-updatepanels">someone else on StackOverflow had the same problem</a>. Luckily, the solution was right there as well.

<pre name="code" language="javascript">
$(document).ready(function() {
    doReady();

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_endRequest(function(s, e) {
        doReady();
    });
});

function doReady() {
    $('.roundedCorners').corners();
}
</pre>

I'm interested in trying the <a href="http://docs.jquery.com/Plugins/livequery">livequery jQuery plugin</a>, but will go with this for now.
