---
title: Welcome to jQuery	
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



My first task at my new organization was to verify text being added to a freeform text field is not already associated to a different record of the same type. This would be similar to checking if a username is taken before completing a registration process. As you have probably encountered with the registration process, the typical way to complete this test is to wait for the user to click save button and then test the database for the existing record. It would be a lot nicer if the test would happen automatically as you type, so this is what I set out to do.

Doing this with ASP.Net AJAX would probably be possible, but given we are starting to invest in jQuery, I took this as a great opportunity to learn something new, while still delivering a great user experience. While working through some quick and dirty jQuery examples, I quickly see its potential. It feels nice to be in a dynamic language for a change. 

My first task was to fire off a function after a certain amount of time elapses without the user typing into the field. I know Javascript provides a timer mechanism, but I'm hoping jQuery provides a nice abstract to it...<a href="http://plugins.jquery.com/project/timers" title="Plugins | jQuery Plugins">and it does</a>. I'm able to find my text box and attach my timers. It was when I first tried to move this out of my static html proof of concept into an ASP.Net application hat I first realized the bane of ASP.Net when using jQuery, control id's.

All of the examples in jQuery have really nice, hand crafted control id's. 
<pre name="code" language="javascript">
	$("#myTextbox").keypress(function(){
		$("#myTextbox").oneTime(1000,"mytimer",function(){alert("times up");});
	});
</pre>
That's great, but my text box is inside a user control, inside another user control, inside a page. I don't get <code>id = "myTextbox"</code>. I get <code>id = "ctl0__ctl1_ctl1_etc_myTexbox"</code>, which makes the selector a little more difficult to write. Luckily, we can use some nasty escaped ASPX code to handle that. I'm not sure this is the best way to handle it, but it is working for now.
<pre name="code" language="javascript">
	&lt;script type="javascript">
		var controlName = "&lt;%= myTextbox.ClientID %>";
		$("#" + controlName).keypress(function(){"pressed it");});
	&lt;/script>
</pre>
On occasion, the client id is not as easy to come across. For example, in my particular case, I am trying to select a text box inside the <code>InsertItemTemplate</code> of a <code>ListView</code>. 
<pre language="javascript" name="code">
&lt;asp:ListView ID="ListView1" runat="server">
    &lt;!-- ... -->
    &lt;InsertItemTemplate>
        &lt;asp:TextBox ID="myTextbox" runat="server" />
        &lt;script language="javascript" type="text/javascript">
            var controlName = '&lt;%= ListView1.InsertItem.FindControl("myTextbox"); %>';
        &lt;/script>
    &lt;/InsertItemTemplate>
&lt;/asp:ListView>
</pre>


...OK. I've learned not to be too ambitious with my blogs post. I'll be contributing in smaller chunks form now on.
