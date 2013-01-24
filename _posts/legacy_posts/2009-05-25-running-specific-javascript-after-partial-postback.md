---
title: Running specific JavaScript after partial postback
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I know how to run JavaScript after every postback, but on occasion I want to run some JS after a specific postback (i.e. show a flash message message that says the processing completed successfully). This hasn't been as simple as I thought it should be. <a href="http://stackoverflow.com/questions/899761/how-to-control-which-javascript-gets-run-after-updatepanel-partial-postback-endre">I even posted to StackOverflow</a> to see if there was something I was missing or if it really is this messy. The only answer I've received to date suggested the method I already had in mind when posting the question, so I thought I would work out the full example and show you how it looks. 

<strong>Background:</strong> First a little background. I have a <code>UserControl</code> that I use to display a nice status and/or error message on all my pages. It's in the master page and has some really convenient JavaScript to show it. For all the ajaxy stuff we do it works great. It flashes in and fades out; however, we can't show it on the partial postback events...yet. We need to run some JS on the client side after the postback is done to either show the error message or success message. 

<strong>Overview:</strong> Basically, we are going to put a hidden field on the page and register an event handler to run after partial postback to see if there is any JavaScript in it, and execute there is. Pretty simple. 

I created a user control to hold all the hidden fields and JS to register the postback events. It is going to get reused in a lot of places so it makes sense to make it reusable. It could be made into a server control, but I'll forgo that for now.

There isn't much to the user control.

<pre name="code" class="html">
&lt;%@ Control Language="C#" 
    AutoEventWireup ="true" 
    CodeFile        ="DoAfterPostback.ascx.cs" 
    Inherits        ="DoAfterPostback" %>        

&lt;asp:HiddenField ID="DoAfterPostbackJavaScriptHiddenField" runat="server" 
    EnableViewState="false" />
</pre>

It'll need some code to create a property to access the JavaScript we want to run and register the event handlers.

<pre name="code" class="c#">
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DoAfterPostback : System.Web.UI.UserControl
{
    public string DoAfterPostbackJavaScript { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(
            this.GetType(),
            "DoAfterPostbackJavaScriptEngine",
            @"            
                var prm = Sys.WebForms.PageRequestManager.getInstance();  
                prm.add_endRequest(function(s, e) {  
                    $('[id$=_DoAfterPostbackJavaScriptHiddenField]').each(doPostbackJS); 
                }); 
                
                function doPostbackJS(i){                    
                    eval(this.value);                    
                }
            
            ",true);
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        DoAfterPostbackJavaScriptHiddenField.Value = DoAfterPostbackJavaScript;
    }
}
</pre>

We probably don't <em>need</em> jQuery in there, but we're already using it so I continued to use it here.

Now let's get to using it. We'll need a page for that.

<pre name="code" language="html">
&lt;%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
&lt;%@ Register src="DoAfterPostback.ascx" tagname="DoAfterPostback" tagprefix="uc1" %>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
&lt;html xmlns="http://www.w3.org/1999/xhtml">
&lt;head runat="server">
    &lt;title>&lt;/title>
    &lt;script type="text/javascript" src="jquery.js">&lt;/script>
    &lt;script type="text/javascript">
        function showMsg(s) {
            alert(s);
        }
    &lt;/script>
&lt;/head>
&lt;body>
    &lt;form id="form1" runat="server">
        &lt;asp:ScriptManager ID="ScriptManager1" runat="server">
        &lt;/asp:ScriptManager>        
        &lt;div>
            &lt;asp:UpdatePanel ID="UpdatePanel1" runat="server">
                &lt;ContentTemplate>
                    &lt;uc1:DoAfterPostback ID="DoAfterPostback1" runat="server" />
                    &lt;asp:TextBox ID="TextBox1" runat="server" />
                    &lt;asp:Button ID="Button1" runat="server" 
                        Text    ="Button" 
                        OnClick ="ButtonClicked" />&lt;br />
                    &lt;asp:Label ID="Label1" runat="server" 
                        Text    ="Label" />
                &lt;/ContentTemplate>
            &lt;/asp:UpdatePanel>            
        &lt;/div>
    &lt;/form>
&lt;/body>
&lt;/html>
</pre>

We have a textbox, button and a label inside an UpdatePanel. We also have our user control in there. This will let the hidden field value change on partial postback and the new value to show up in our event handler. In addition, there is a trivial JavaScript function on the page for us to call after the postback:<code>showMsg</code> . Technically we could just throw the alert right in our control, but this more closely mimics how we're going to do for real.

Finally we need some code on the server side to put some JS in our hidden field.

<pre name="code" language="c#">
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page 
{    
    protected void ButtonClicked(object sender, EventArgs e)
    {
        var s = TextBox1.Text;
        if (string.IsNullOrEmpty(s)) return;

        Label1.Text = string.Format("The user says {0}.", s);
        DoAfterPostback1.DoAfterPostbackJavaScript = "showMsg('" + s + "');";
    }
}
</pre>

That should be it. Now we can enter text, hit the button and see both our server side processing take place and the client side JavaScript execute after the postback as completed.
