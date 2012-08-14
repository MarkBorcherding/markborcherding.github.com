---
title: jQuery and Event Delegation Example
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I wanted to give some examples that actually run. The last post might have been a little abstract and brief.

First, don't forget to link in the jQuery script.

<pre language="html" name="code">
&lt;script src="jquery-1.2.6.js" type="text/javascript" charset="utf-8">&lt;/script>	
</pre>

Some CSS to pretty things up.

<pre language="css" name="code">
	.myContainer{
		width:300px;
		font-family:Arial;
	}

	.fooberry{
		margin:5px;
	}
	.summary{
		background-color:blue;
		color:white;
		padding:3px;		
	}

	.details{
		background-color:green;
		color:white;
	}

	.toolbar-details{
		cursor: pointer;
	}
</pre>

Some HTML to manipulate.

<pre name="code" language="html">
&lt;div class="myContainer">
	&lt;div class="fooberry">
		&lt;div class="summary">
			&lt;div class="summary-text">
				Just a little information.
			&lt;/div>
			&lt;div class="toolbar">
				&lt;span class="toolbar-details">details&lt;/span> |
				&lt;span>date: 1/3/2009&lt;/span>
			&lt;/div>
		&lt;/div>
		&lt;div class="details">
			More information....
		&lt;/div>
	&lt;/div>

	&lt;div class="fooberry">
		&lt;div class="summary">
			&lt;div class="summary-text">
				Different information.
			&lt;/div>
			&lt;div class="toolbar">
				&lt;span class="toolbar-details">details&lt;/span> |
				&lt;span>date: 1/4/2009&lt;/span>
			&lt;/div>
		&lt;/div>
		&lt;div class="details">
			More information....
		&lt;/div>
	&lt;/div>


&lt;/div>
</pre>
	
Finally the jQuery.
<pre name="code" language="javascript">
&lt;script>
	$(document).ready(function(){
		$(".fooberry").click(function(e){
			if($(e.target).is(".toolbar-details")){
				$(this).find(".details").slideToggle(500);
			}
		});
	});
&lt;/script>
</pre>

This layout could probably be adjusted so the problems I mentioned in the previous post aren't a problem, but let's just look at the event delegation. 

The div with the class "fooberry" contain the physical layout for the items of our list. We use jQuery to attach a click event handler to each "fooberry" div and then use jQuery again to examine the arguments of the event, and yet again to find the div we want to toggle. 

I am sure it is possible to attach the event to the "myContainer" div. We would need some additional jQuery since the following line would find <em>all</em> "details" divs.

<pre name="code" language="javascript">
$(this).find(".details").slideToggle(500);
</pre>

This happens because the "this" in this statement will now be the "myContainer" div. We could probably write a query to find the parent of the "e.target" who's class is "fooberry", and then use that element in place of "this" in the previous statement. This would reduce the overhead of the redundant event handlers, and work with all additional "fooberry" divs added via Ajax.

I hope this is useful for you as it is for me.

Here is the entire HTML.

<pre language="html" name="code">
	&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
	   "http://www.w3.org/TR/html4/strict.dtd">

	&lt;html lang="en">
	&lt;head>

		&lt;script src="jquery-1.2.6.js" type="text/javascript" charset="utf-8">&lt;/script>

		&lt;meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		&lt;style>
			.myContainer{
				width:300px;
				font-family:Arial;
			}

			.fooberry{
				margin:5px;
			}
			.summary{
				background-color:#373999;
				color:white;
				padding:3px;		
			}

			.details{
				background-color:#689980;
				color:white;
			}

			.toolbar-details{
				cursor: pointer;
			}
		&lt;/style>

		&lt;script>
			$(document).ready(function(){

				$(".fooberry").click(function(e){
					if($(e.target).is(".toolbar-details")){
						$(this).find(".details").slideToggle(500);
					}
				});
			});
		&lt;/script>

	&lt;/head>
	&lt;body>

		&lt;div class="myContainer">
			&lt;div class="fooberry">
				&lt;div class="summary">
					&lt;div class="summary-text">
						Just a little information.
					&lt;/div>
					&lt;div class="toolbar">
						&lt;span class="toolbar-details">details&lt;/span> |
						&lt;span>date: 1/3/2009&lt;/span>
					&lt;/div>
				&lt;/div>
				&lt;div class="details">
					More information....
				&lt;/div>
			&lt;/div>

			&lt;div class="fooberry">
				&lt;div class="summary">
					&lt;div class="summary-text">
						Different information.
					&lt;/div>
					&lt;div class="toolbar">
						&lt;span class="toolbar-details">details&lt;/span> |
						&lt;span>date: 1/4/2009&lt;/span>
					&lt;/div>
				&lt;/div>
				&lt;div class="details">
					More information....
				&lt;/div>
			&lt;/div>


		&lt;/div>

	&lt;/body>
	&lt;/html>
	
</pre>
