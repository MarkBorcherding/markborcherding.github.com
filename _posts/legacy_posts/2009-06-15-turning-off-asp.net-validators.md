---
title: Turning Off ASP.Net Validators
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>In true web forms style, what should be simple is more difficult than it should be, at least in my opinion. Today I needed the following simple UI.</p>  <p><a href="http://www.balsamiq.com/"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2009/06/image4.png" width="274" height="105" /></a> </p>  <p>Simple enough right? Pick something from the list or type your own text. The JavaScript to enable and disable the controls wasnt too bad. Its pretty un-interesting, so Ill just skip over it. What I found surprising was the validators were still firing even though the controls were disabled. I wasnt expecting it, but oh well. Now to turn off the controls validators.</p>  <p>I found a lot of examples that looked like the following:</p>  <pre language="javascript" name="code">var myVal = document.getElementById('somevalidatorid');
ValidatorEnable(myVal, false); </pre>

<p>Thats nice, but I really dont want to have to <em>know</em> each and every validator id for each control. It would also make the generic enable/disable code really tightly coupled to the controls were trying to disable.</p>

<p>Luckily, we can just find all the validators manually. jQuery can help us out, but isnt <em>really </em>required.</p>

<pre language="javascript" name="code">function enableAllValidatorsFor(control,shouldEnable){
    var validators  = $.grep(Page_Validators,   
				function(validator,i){
                                	return validator.controltovalidate == control.id; 
                                });
    $.each(validators,  function(i,validator) {                                     
                            ValidatorEnable(validator,shouldEnable); 
                        });    
                        
    // the validator callout leaves the error 
    // class on the control after the validator gets
    // disabled, so we have to clean that up. 
    if(!shouldEnable){
        $(control).removeClass(&quot;error&quot;);
    }
}        </pre>

<p>The last little bit of code removes a CSS class that is set via a validator callout. It is tightly coupled with our pages, so you probably wont need it, or will need a different class name. However, even though it is tightly coupled, its couple to all the pages and not the instance of the control it is disabling. We probably could find the validtor callouts used by the validator controls being disabled and remove any of the error classes they apply, but that didnt seem necessary right now.</p>

<p>Something else interesting is the inconsistency of the jQuery API in this case. In the grep and each method the order of the arguments is reversed in the callback. </p>

<p>For <a href="http://docs.jquery.com/Utilities/jQuery.grep#arraycallbackinvert">grep</a> you have:</p>

<pre language="javascript" name="code">function grepCallback(item, index){}</pre>

<p>..and for <a href="http://docs.jquery.com/Utilities/jQuery.each#objectcallback">each</a> you have:</p>

<pre language="javascript" name="code">function eachCallback(index,item){}</pre>
