---
title: ReSharper tip of the Day -- Move Code Left and Right
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Josh showed us <a href="/2008/08/13/resharper-tip-of-the-day-move-member-updown/">how to slap around our code</a> with <em>CTRL+ALT+SHIFT+UP|DOWN</em>. We can now smack around our markup a little further. In addition to the four fingered up and down bully job, we and take an attribute left or right in the pecking order of the opening tag.

<img class="alignnone size-full wp-image-403" title="11" src="/wp-content/uploads/2008/10/11.png" alt="" width="551" height="154" />

<em>CTRL+SHIFT+ALT+LEFT|RIGHT</em> (right in this case) bumps the attribute over.

<img class="alignnone size-full wp-image-404" title="2" src="/wp-content/uploads/2008/10/2.png" alt="" width="563" height="157" />

If you prefer a more vertical representation of the attributes like the following, the command still works, but less intuitive since left and right actually move it up and down, and up and down move the entire tag up and down.
<pre name="code" language="xml">
&lt;CheckBox 
     Margin="0,0,0,0"
     Unchecked="DoUnchecked"
     Checked="DoChecked">
     Some Text
&lt;/CheckBox>              
</pre>

One last thing to note is <strong>you do not need to select the entire attribute</strong>. Having the cursor in the attribute you wish to move is enough.
