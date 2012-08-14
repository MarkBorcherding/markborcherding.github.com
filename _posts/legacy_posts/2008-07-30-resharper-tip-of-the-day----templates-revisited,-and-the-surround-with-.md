---
title: ReSharper Tip of the Day -- Templates Revisited, and the Surround With 
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Today's ReSharper Tip of the Day is a guest posting from Josh Buedel, It is a great tip that extends ReSharper's use into the CSS and HTML space.
<blockquote>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">Resharper templates come in two flavors: Live Templates which are invoked by typing keyword and pressing tab, and Surround With Templates, which are invoked against the current selection.</p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">Did you know that R# templates can be used in any file type? You aren't limited to just the sections of files that it understands. For example I've built up a handful of templates for Aspx pages. Surround With templates are particularly useful in a markup language like html.</p>
<p style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">I first invoke my custom Surround With CSS Comment (Ctrl+Alt+J).</p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"><span style="mso-bidi-font-family: Arial; mso-bidi-language: AR-SA;"><img class="alignnone size-full wp-image-142" title="csscomment" src="/wp-content/uploads/2008/07/csscomment.jpg" alt="" width="430" height="264" /><img class="alignnone size-full wp-image-143" title="csscommentcomplete" src="/wp-content/uploads/2008/07/csscommentcomplete.jpg" alt="" width="287" height="215" /></span></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
<p style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">Then I type the keyword data and hit Tab, which invokes a custom live template for databinding code.</p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"><span style="mso-bidi-font-family: Arial; mso-bidi-language: AR-SA;"><img class="alignnone size-full wp-image-144" title="databinder" src="/wp-content/uploads/2008/07/databinder.jpg" alt="" width="426" height="77" /><img class="alignnone size-full wp-image-145" title="databindercomplete" src="/wp-content/uploads/2008/07/databindercomplete.jpg" alt="" width="500" height="67" /></span></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">In this one I select all that and again do a Surround With, this time using my custom Link Tag (&lt;a/&gt;) template.</p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"><span style="mso-bidi-font-family: Arial; mso-bidi-language: AR-SA;"><img class="alignnone size-full wp-image-146" title="databindertolink" src="/wp-content/uploads/2008/07/databindertolink.jpg" alt="" /><img class="alignnone size-full wp-image-147" title="databindertolinkcomplete" src="/wp-content/uploads/2008/07/databindertolinkcomplete.jpg" alt="" /></span></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">Lastly, I have this generic tag inserter.</p>
<p style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"><a href="/wp-content/uploads/2008/07/tag1.jpg"><img class="alignnone size-full wp-image-150" title="tag1" src="/wp-content/uploads/2008/07/tag1.jpg" alt="" width="282" height="248" /></a><img class="alignnone size-full wp-image-151" title="tag2" src="/wp-content/uploads/2008/07/tag2.jpg" alt="" width="235" height="48" /><img class="alignnone size-full wp-image-152" title="tag3" src="/wp-content/uploads/2008/07/tag3.jpg" alt="" width="150" height="34" /><a href="/wp-content/uploads/2008/07/tag1.jpg"><img class="alignnone size-full wp-image-153" title="tag4" src="/wp-content/uploads/2008/07/tag4.jpg" alt="" width="195" height="53" /></a></p>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;">Notice how as I change the name of the opening tag, the end tag is updated right along with it. I accomplish this by repeating my template variable (which I have named $TAG$) within the template. Once the template mode is exited the cursor ends up positioned inside the opening tag, but just before the closing &gt; character. This is by design, by using the predefined $END$ variable, and is right where I would need to be to insert an attribute should one be needed. Here's the complete template for this:</p>

<div class="mceTemp"><dl id="attachment_149" class="wp-caption alignnone" style="width: 623px;"><dt class="wp-caption-dt"><img class="size-full wp-image-149" title="edittagtemplate" src="/wp-content/uploads/2008/07/edittagtemplate.jpg" alt="" width="613" height="562" /></dt><dd class="wp-caption-dd"></dd></dl>...</div>
<p class="MsoNormal" style="margin: 0in 0in 0pt; mso-layout-grid-align: none;"></p>
</blockquote>
