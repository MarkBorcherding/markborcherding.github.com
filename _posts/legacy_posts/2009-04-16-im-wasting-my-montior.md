---
title: Im Wasting My Montior
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I know Im wasting my 24 widescreen monitor, but I dont like the layout of the following markup.
<pre class="html" name="code">
&lt;asp:TextBox runat="server" ID="txtPasswordExisting" 
   TextMode="Password" />
&lt;asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" 
   CssClass="error" ControlToValidate="txtPasswordExisting"
    Display="Dynamic" Text="Username is required." ValidationGroup="AssociateAccount" />                                  
&lt;cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server" TargetControlID="RequiredFieldValidator2"
    HighlightCssClass ="error" CssClass ="validatorCallout" />  
</pre>

I would prefer this.
<pre class="html" name="code">
&lt;asp:TextBox runat="server" ID="txtPasswordExisting" 
    TextMode    ="Password" />
&lt;asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" 
    CssClass            ="error" 
    ControlToValidate   ="txtPasswordExisting"
    Display             ="Dynamic" 
    Text                ="Username is required." 
    ValidationGroup     ="AssociateAccount" />                                  
&lt;cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server" 
    TargetControlID     ="RequiredFieldValidator2"
    HighlightCssClass   ="error"
    CssClass            ="validatorCallout" />  
</pre>

...OK. It doesn't display nicely in the syntax highlighter because of the proportional width font, but you get the idea.

Im sure in most peoples mind it is wasted vertical space, but it makes doing diffs so much easier and my eyes easily see the grouping of controls and their attributes.
