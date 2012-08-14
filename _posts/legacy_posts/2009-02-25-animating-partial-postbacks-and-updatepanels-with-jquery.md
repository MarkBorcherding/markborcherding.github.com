---
title: Animating Partial Postbacks and UpdatePanels with jQuery
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Update panels make it really easy to do <em>pseudo ajaxish</em> stuff with little or no extra effort. Wrap your controls in a an <code>UpdatePanel</code>, pay for the entire page to post back and go through its life-cycle and you're pretty much there. I've already written a bit on the extra steps you'll need if you're doing some jQuery magic inside that <code>UpdatePanel</code>. It's not difficult and easy enough to either delegate up the chain to something outside the <code>UpdatePanel </code>(e.g.<a href="/2009/01/03/jquery-and-event-delegation/"> event delegation</a>) or rinse and repeat the jQuery after the partial post back is complete (e.g. <code><a href="/2009/01/06/563/">add_endRequest</a></code>).

What would be really slick-o-matic is if we could do some animation to transition the partial postback so it wouldn't just explode with new content in our face. Now granted, that may be an overstatement.  The content changes usually aren't drastic or very distracting to but let's add a bit of polish.

Keep in mind this is a first draft, done in about 30 minutes after an idea landed in my head at 3am. It still needs some polishing, but the major hurdles are taken care of. 

For our example, we'll have a simple Div that will be worked upon in a partial postback. Our goal will be to gently transition the display of that work to the user.  Something like this.
                                    <embed width="440" height="420" type="application/x-shockwave-flash" src="http://v5.tinypic.com/player.swf?file=27y6dm0&s=5" FlashVars="gig_lt=1235535494596&gig_pt=1235535644676&gig_g=1"><br><font size="1"><a href="http://tinypic.com/player.php?v=27y6dm0&s=5">Original Video</a> - More videos at <a href="http://tinypic.com">TinyPic</a></font>
                                <img style="visibility:hidden;width:0px;height:0px;" border=0 width=0 height=0 src="http://counters.gigya.com/wildfire/IMP/CXNID=2000002.0NXC/bT*xJmx*PTEyMzU1MzU*OTQ1OTYmcHQ9MTIzNTUzNTY*NDY3NiZwPTIzNDQ3MSZkPSZnPTEmdD*mbz*wZWQzMDVkMmQxOGU*Nzc*OWE*ZGU5OWRkYjNhNGE2ZA==.gif" />

We'll start off with some basic styles to help illustrate the change. We'll change the content of the Div and also the class.

<pre name="code" class="css">
	#mydiv{ width:200px; border:solid 1px black; font-size:xx-large; } 
	.myclass0 { height:200px; background-color:Blue; }        
	.myclass1 { height:100px; background-color:Red; }
	.myclass2 { height:150px; background-color:Lime; }
	.myclass3 { height:50px; background-color:Purple; color:White; }
</pre>

Nothing too exciting, but our partial postback will give us some new dimensions and style. It'll get the point across.

Next we need some HTML.

<pre name="code" class="html">
&lt;form id="form1" runat="server">
	&lt;asp:ScriptManager ID="ScriptManager1" runat="server">
	&lt;/asp:ScriptManager>
	&lt;div> 
		Original time: <%= DateTime.Now.ToLongTimeString() %><br />        
		&lt;asp:UpdatePanel ID="UpdatePanel1" runat="server">
			&lt;ContentTemplate>
				&lt;asp:Button runat="server" Text="Button" ID="MyButton"  
						OnClick="MyButtonClick" 
					OnClientClick="return ClientClick(this,'#mydiv'); " />
				&lt;div id="mydiv" runat="server">
					&lt;asp:Label runat="server" Text="Label"                     
                                           ID="MyLabel">&lt;/asp:Label>
				&lt;/div>
			&lt;/ContentTemplate>
		&lt;/asp:UpdatePanel>                        
	&lt;/div>
&lt;/form>
</pre>

The magic is going to live in the <code>ClientClick </code>event handler, but forget about that for now. The server side <code>OnClick </code>event will do some trivial work.

<pre name="code" class="c#">
 protected void MyButtonClick(object sender, EventArgs e)
 {
	 MyLabel.Text = DateTime.Now.ToLongTimeString();
	 var c = "myclass" + DateTime.Now.Millisecond % 4;
	 mydiv.Attributes.Add("class",c);
 }
</pre>

This could just as easily toggled a view from edit mode to read-only, expanded a detailed area, etc. Here, we are just picking one of four css classese to use on the div and also giving a label the current time. Like I said this isn't the cool part. 

The final steps are to do the following:
<ul>
<li>Get the jQuery animation to happen on the click of the button.</li>
<li> Get the partial postback to wait until the animation is done.</li>
<li> Get the DOM to appear in the pre-animation state when it comes back from the partial postback.</li>
<li>Get the animation to happen once we have the new page ready to go.</li>
</ul>

The function needs to know what needs to be animated upon. I've been using slide transitions, but the animation is something I think can very easily be abstracted out. We make some quick tests to see if we are in the process of animating or if the animation has been completed. I struggled with how to delay the button click's post back from happening until the animation is complete and finally decided to just let it happen a second time, but to flag the second click to allow it to continue posting back. I'm using the jQuery data feature to keep some state about the button. 

If we are currently sliding, then there is nothing left to do, and if we are done sliding then we can skip the other steps and continue the postback.
<pre class="javascript" name="code">
if (d.data("isSliding")) return false;
if (d.data("doneSliding")) return true;
</pre>

If we don't meet those conditions, we need to slide. We set our flag, wire up the end request handler and the callback to the slide method and kick off the slide.  

The slide method is the simplest. 
<pre class="javascript" name="code">
d.slideUp(500,
	function() {
		d.data("isSliding", false);
		d.data("doneSliding", true);
		$(sender).click();                    
	});
</pre>	
Slide our control up, and when we're done, set some flags and kick off the click a second time. With the flags set, we'll fire off the postback. Nothing really fancy here either. Notice we can still reference <code>d</code> here. We don't need to find it again. 

The <code>endRequest </code>handler looks a bit more involved. 
<pre class="javascript" name="code">
var prm = Sys.WebForms.PageRequestManager.getInstance();

var f = function(s, e) {		
	d = $(whatToSlideDown);
	d.css("display", "none");
	d.slideUp(0);
	d.slideDown(500);
	prm.remove_endRequest(f);
}

prm.add_endRequest(f);
</pre>
Here, inside the function we do need to ask jQuery to find what we want again. The DOM has been changed and the old d we created from<code> $(whatToSlideUp) </code>probably isn't there anymore. In addition, we need to set the element in the state we left the old element. In this case, we want the display to be set to "none". This allows the <code>slideDown </code>to work just like we would expect following a <code>slideUp</code>.

This is part of the setup that I don't like. I've tried quickly running a <code>slideUp(0)</code> on the the new elements, but I was seeing a flash of the default state before getting the slide up. This is something that I would like to factor out. The animation, including this default state should be a  parameter to the function.

Here is a look at the function as a whole. It's a stupid function name I know, but that is easily changed. 
<pre class="javascript" name="code">
function ClientClick(sender,whatToSlideUp,whatToSlideDown) {

	if (!whatToSlideDown)
		whatToSlideDown = whatToSlideUp;

	var d = $(whatToSlideUp);

	if (d.data("isSliding")) return false;
	if (d.data("doneSliding")) return true;

	d.data("isSliding", true);

	var prm = Sys.WebForms.PageRequestManager.getInstance();

	var f = function(s, e) {		
		d = $(whatToSlideDown);
		d.css("display", "none");
		d.slideUp(0);
		d.slideDown(500);
		prm.remove_endRequest(f);
	}

	prm.add_endRequest(f);

	d.slideUp(500,
		function() {
			d.data("isSliding", false);
			d.data("doneSliding", true);
			$(sender).click();                    
		});
	return false;
}        
</pre>
That's it.  There is definitely room to polish this up and make it more flexible. I'll post back when I get it up and running in a real application so it looks more useful.
