---
title: jQuery and Event Delegation
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



We're currently implementing a collapsible panel in one of our web pages using the ASP.Net Ajax Collapsible Panel Extender. The problem we are having is the Collapsible Panel Extender requires Control ID's for the expand, collapse and target controls. 

Usually this isn't a problem, but we want to expand a panel inside a ListView control when a something is clicked outside the ListView. So now the problem is he only way to find the control ID is to do a complicated a string of <code>.Parent</code> and <code>.FindControl("")</code> calls to eventually call the <code>.ClientID</code> of the control we want. This becomes very brittle as the code breaks if the UI changes and some expects a parent to be there, when it's been moved in he markup. This obviously needs to change.

So now to try it (the first way) in jQuery. It should be very easy right?

<pre language="javascript" name="code">
	$("#" + buttonID).click(function(){
							$("#" + panelID).slideToggle(500);
						  });
</pre>

Again, we have the same problem. The <code>buttonID</code> and <code>panelID</code> are not easy to get. We need that nasty <code>ClientID</code>; however, what dropping the ASP.Net controls in favor of old school HTML controls. We would end up with something like this?

<pre language="javascript" name="code">
	$('#button&lt;%# Eval("myPK") %>').click( //...
</pre>

Ugh...that will work, but it looks nasty too. Generating Javascript on the fly is cool and all I guess, but I don't like it here.

Here comes Event Delegation to the rescue. Instead of attaching that <code>click</code> event handler to the actual item, let the event delegate up to a parent container, and catch it there. Then, using jQuery to only peer downward is elegant.

<pre language="javascript" name="code">
	$(document).ready(function(){
		$(".outerDiv").click(function(e){
			if($(e.target).is(".collapseButton")){
				$(this).find(".collapsePanel").slideToggle(500);
			}
		})
	});
</pre>

That's it! That's awesome! It works every time it appears on the page. Remember, we are inside a ListView so we repeat the need for this several times. We don't care what is between the element with the "outerDiv" CSS class and the other elements because jQuery takes care of finding them. We're no longer brittle!  We don't need the control ID's because we only care about the CSS classes now. No more Control ID's! We no longer have difficulty finding out second cousin twice removed element because we found a common ancestor and look down from there. We don't need to assign event handles for each button. Sweet! It is a win/win/win.
