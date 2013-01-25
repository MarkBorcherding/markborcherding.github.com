---
title: Sharing master pages between WebForms and MVC
layout: post
description: "Something really cool"
category:
tags: [ ]
---
<p>Lets face it. Everyone loves MVC. At least all the web purists love it. Its clean, straight forward, and very testable. But lets also face it. We have a huge investment in WebForms. I mean up until now, 100% of the stuff we built was WebForms, include 100% of the master pages. </p>  <p>These pages govern how&#160; the entire site looks and a wee bit of its functionality. </p>  <p><a href="/wp-content/uploads/2010/03/a.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="a" border="0" alt="a" src="/wp-content/uploads/2010/03/a_thumb.png" width="293" height="250" /></a> </p>  <p>It would be a real shame if we had to start being less DRY and copy all that markup, in potentially many files, to new, MVC master pages. Luckily, you dont.</p>  <p><strong>Let me stop right there</strong>. Technically, no, you dont. Mvcs <a href="http://msdn.microsoft.com/en-us/library/system.web.mvc.viewmasterpage.aspx">ViewMasterPage</a> (VMP) inherits from <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.masterpage.aspx">MasterPage</a> (MP), so you can just tell your VMP to use the MP you want and it will work, <strong>unless you have the single line I hate more than any other lines in your MP.</strong></p>  <pre class="html" name="code">&lt;form id=Form1 runat=server&gt;</pre>

<p>&#160;</p>

<p>So this single line blows the possibility of using the master page as a VMP out of the water. No problem right, include that in a nested MP and put that runat=server around the content place holder, right?</p>

<p><a href="/wp-content/uploads/2010/03/a_3.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="a_3" border="0" alt="a_3" src="/wp-content/uploads/2010/03/a_3_thumb.png" width="489" height="474" /></a> </p>

<p>Thats nice and all, but all those other bit out side of the WebForms specific master page needs to be inside that stupid form.</p>

<p><a href="/wp-content/uploads/2010/03/image.png"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="image" border="0" alt="image" src="/wp-content/uploads/2010/03/image_thumb.png" width="605" height="271" /></a> </p>

<p></p>

<p>Uh oh! No way around that one! Either move the run at server form outside or convert those controls. Id vote for convert the controls. </p>

<p>OK, so how about just use partial views and HtmlHelpers. That sounds like a good idea. Heres another problem.</p>

<pre class="html" name="code">&lt;%= Html.MyMenu() %&gt;</pre>

<p>&#160;</p>

<p>System.Web.UI.MasterPage does not have a HtmlHelper attribute where we get all those nice HtmlHelper Extensions. What about just creating one and using it?</p>

<pre class="html" name="code">&lt;%= new HtmlHelper(null,null).MyMenu() %&gt;</pre>

<p>&#160;</p>

<p>Great! That compiles, but dont get too excited. It doesnt run. We cant just pass null into HtmlHelper. We can new up the first parameter and create our own custom implementation of the second and it does work. </p>

<pre class="html" name="code">&lt;%= new HtmlHelper(new ViewContext(), new FakeViewDataContainer).MyMenu() %&gt;</pre>

<p>&#160;</p>

<p>That looks nasty too, but since that is my own customer helper extension, when not just call into that directly.</p>

<pre class="html" name="code">&lt;%= MyMenuHelper.MyMenu(null) %&gt;</pre>

<p>&#160;</p>

<p>Thats better, and since we arent using the HtmlHelper at all, we can clean up the syntax just a bit.</p>

<pre class="html" name="code">&lt;%= MyMenuHelper.CreateMenu() %&gt;</pre>

<p>&#160;</p>

<p>I can live with that, but if we ever need to do anything complicated that requires view data or other information to be passed along, were in a nasty situation. This works for us for now, so were going to ride this idea for a little longer and see how it goes. </p>

<p>Eventually all those WebForms pages will be moved over to MVC and this wont be an issue. Well have <em>only</em> the MVC master page and everything will be simple. </p>
