---
title: jQuery Selectors and ASP.Net Controls
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>As Ive already mentioned, this is the bane of jQuery within an ASP.Net application. Selecting the control based on its ID becomes difficult with ASP.net Controls and even worse with naming containers. There have been a few methods Ive used to find the ASP.Net control in the dom.</p>  <h2>Injecting the ClientID</h2>  <pre language="javascript" name="code">$(#&lt;%= fooTextBox.ClientID %&gt;)</pre>

<p>This is my least favorite, but the most precise. There are no additional elements or attributes to add and youre guaranteed to get the exact control youre after. Another bad side effect is the javascript has to be inside the ASPX page. Thats not ideal either, although you could argue that having a small script that just has variables for the control names isnt that bad.</p>

<pre language="javascript" name="code">var fooTextBoxClientID = &lt;%= fooTextBox.ClientID %&gt;;</pre>

<p>Still icky.</p>

<h2>Add Custom Attribute</h2>

<p>You could add a custom ID in the markup of the control. </p>

<pre language="html" name="code">&lt;asp:TextBox runat=server id=fooTextBox myID=foo /&gt;</pre>

<p>Then select on that custom ID.</p>

<pre language="javascript" name="code">$(input[myID=foo])</pre>

<p>This seems to make the code less <a href="http://en.wikipedia.org/wiki/Don%27t_repeat_yourself">DRY</a>, but it works well. </p>

<h2>Find With Ending</h2>

<p>Since the name you give you .Net control is only prepended with its naming garbage, you can still find your names using the <em>ends with</em> selector.</p>

<pre language="javascript" name="code">$(input[ID$=fooTextBox]")</pre>

<p>This works well when the controls are assured to appear only once of the form; however, when inside a repeating control such as a ListView or a reusable control, this method falls apart.</p>

<h2>Find With Class</h2>

<p>I probably use this method more than any other since most of the time I have a parent frame of reference which limits the scope enough that makes my class name unique. That scope limiter also helps with the other methods, but using class names has worked the best for me.</p>

<pre language="javascript" name="code">$(.inputTextBox&quot;)</pre>

<p>Be careful not to use the CSS class like you would ID and create a CSS class for <em>every</em> element.</p>

<h2>Wrap in HTML Elements</h2>

<p>Also, you can wrap the control in an HTML element that will provide you full control over its ID.</p>

<pre language="html" name="code">&lt;span id=fooText&gt;&lt;asp:TextBox runat=server ID=FooTextBox /&gt; &lt;/span&gt;</pre>

<p>Then select it using the child / ancestor selector.</p>

<pre language="javascript" name="code">$(#fooText &gt; input)</pre>

<p>Youre adding unneeded markup here, but you might already have it and just need to add the ID attribute, or select it using the class name.</p>

<p>I hope this helps with some headaches surrounding ASP.Net and jQuery.</p>

<strong>Update:</strong> Since then, I've been using the following method more and more. The only change I've made is I've started to prefix my control name with the "_" to make sure I'm not picking up any control names that might carry similar ending names. 

Like...
<pre language="javascript" name="code">
$(input[ID$=_PhoneTextBox]")
</pre>
and...
<pre language="javascript" name="code">
$(input[ID$=_CellPhoneTextBox]")
</pre>

Without the "_" both would match the following.
<pre language="javascript" name="code">
$(input[ID$=PhoneTextBox]")
</pre>
