---
title: ReSharper Tip of the Day -- Put into 'using' construct.
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



There has been some debate if you need <em>every</em> <code>IDisposable</code> should be disposed. From <a href="http://msdn.microsoft.com/en-us/library/system.idisposable.aspx">the documentation</a> <code>IDisposable </code>is used to clean up any unmanaged resource.
<blockquote>Use the Dispose method of this interface to explicitly release unmanaged resources in conjunction with the garbage collector.</blockquote>
OK. That's fine. I totally agree with that until I see <code>DataTable </code>is derived from a class, <code>MarshallByValueComponent</code>, that implements <code>IDisposable</code>. Does that mean <code>DataTable </code>has unmanaged resources? Any way, on to the tip.

ReSharper notices when an object is created that implements <code>IDisposable</code> and it can automatically wrap the usage in a <code>using </code>block. Say you have the following code:

<img class="alignnone size-full wp-image-493" title="1" src="/wp-content/uploads/2008/11/1.png" alt="" width="279" height="220" />

...and want to put it in a <code>using </code>block. Trusty ALT+Enter steps in a gives you the following options:

<img class="alignnone size-full wp-image-494" title="2" src="/wp-content/uploads/2008/11/2.png" alt="" width="331" height="201" />

It is creates a nice <code>using </code>block around the object and all of its usages.

<img class="alignnone size-full wp-image-495" title="3" src="/wp-content/uploads/2008/11/3.png" alt="" width="288" height="166" />

What would really be nice is we could create a warning when we see ourselves using an <code>IDisposible </code>without calling <code>Dispose</code>. That might be more difficult than finding one outside of a using. We could be calling <code>Dispose </code>in a <code>try</code>/<code>finally </code>or somewhere else.
