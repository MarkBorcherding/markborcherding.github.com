---
title: Rebasing Javascript via a MasterPage
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I've been looking for a way to rebase the URL for the javascript we include in our master pages. We add a lot of javascript in the master pages such as the following.
<pre language="html" name="code">
    &lt;link href="../css/ui-theme.css" rel="stylesheet" type="text/css" />
    &lt;script language="javascript" type="text/javascript" src="../js/jquery-1.3.js" />
</pre>
The problem is, as everyone probably knows, the relative path to the file is from the master page, not from the client page. For some reason, ASP.Net is kind enough to rebase the <code>link</code> tag's <code>href</code> property, but not the javascript link. 

After asking the Google, I saw a lot of examples to solve the problem like by using the <code>ResolveClientUrl</code> as follows:
<pre language="html" name="code">
    &lt;script language="javascript" type="text/javascript" 
        src='&lt;%= ResolveClientUrl("~/js/jquery-1.3.js") %>' />
    &lt;!-- or -->
    &lt;script language="javascript" type="text/javascript" 
        src='&lt;%# ResolveClientUrl("~/js/jquery-1.3.js") %>' />
</pre>
However, I saw no one suggest this, which I believe to be a little cleaner.
<pre language="html" name="code">
    &lt;asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        &lt;Scripts>
            &lt;asp:ScriptReference Path="~/js/jquery-1.3.js" />
        &lt;/Scripts>
    &lt;/asp:ScriptManager>
</pre>

Granted, this brings in some ASP.Net Ajax that may ugly things up, but it works for our own javascript files.
