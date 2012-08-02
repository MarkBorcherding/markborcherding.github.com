---
title: WPF Toolkit DataGrid, ColumnHeader Style and Blend
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



I've spent the better part of the day trying to figure out how to style the column headers of my WPF Toolkit datagrid through Microsoft Blend. Blend is a great tool and I couldn't imagine trying to do a WPF application without it; however it is still immature and this could be why I found it so difficult to figure out. It could just be that I'm new to  Blend, WPF, and XAML and still have a lot to learn.

I'll spare you the agony I suffered this morning and jump right into the solution.

We have a pretty basic style for the datagrid at the moment. You'll have to forgive the visual obfuscation.
<img title="11" src="/wp-content/uploads/2008/11/11-300x69.png" alt="" width="300" height="69" />

Changing the the column header style looked pretty obvious in Blend. The menu walks me through the steps to create a resource for the header style.

<img class="alignnone size-full wp-image-521" title="21" src="/wp-content/uploads/2008/11/21.png" alt="" width="747" height="653" />

Give the style resource a name. In this case I am going to show a pivoted set of data with a set of frozen columns on the left and columns that accept entering data on the right. I give it the name I want and choose its destination.
<img class="alignnone size-full wp-image-522" title="31" src="/wp-content/uploads/2008/11/31.png" alt="" width="386" height="254" />

When the steps are complete, I have a style in the resources dictionary for my window, but something is missing.

<img class="alignnone size-full wp-image-523" title="4" src="/wp-content/uploads/2008/11/4.png" alt="" width="345" height="464" />

<div style="padding: 1em 0pt; text-align: left;">I'm not sure if I'm missing a step, but the target type of the resource is the generic IFrameInputElement type. It doesn't provide any properties to set in the designer.<img class="alignnone size-full wp-image-524" title="5" src="/wp-content/uploads/2008/11/5.png" alt="" width="376" height="238" /></div>
<div style="padding: 1em 0pt; text-align: left;">If I look at the XAML that was created, it doesn't give it a type.</div>

<pre language="xml" name="code">&lt;Style x:Key="EnterableColumnHeaderStyle"/&gt;</pre>

The examples I've been seeing have a TargetType property to allow for the attached properties to work properly. I got ahead and add my TargetType property.

<img class="alignnone size-full wp-image-525" title="6" src="/wp-content/uploads/2008/11/6.png" alt="" width="835" height="78" />

As you can see, I'm still learning WPF and XAML. ReSharper steps in and offers to help out a bit. I am glad to let it. It adds the proper namespace to the resource:

<pre language="xml" name="code">
&lt;Style x:Key="EnterableColumnHeaderStyle" TargetType="primitives:DataGridColumnHeader"&gt;
</pre>

It also creates the namespace directive:

<a href="/wp-content/uploads/2008/11/7.png"><img class="alignnone size-medium wp-image-526" title="7" src="/wp-content/uploads/2008/11/7-300x72.png" alt="" width="300" height="72" /></a>

I don't really like the namespace alias, so we'll change it with the help of ReSharper.
<div id="s8t." style="padding: 1em 0pt; text-align: left;"><img class="alignnone size-full wp-image-527" title="8" src="/wp-content/uploads/2008/11/8.png" alt="" width="500" height="173" /></div>

Blend now knows our target type and gives us all the properties we could want to style.
<div id="ydpf" style="padding: 1em 0pt; text-align: left;"><img class="alignnone size-full wp-image-528" title="9" src="/wp-content/uploads/2008/11/9.png" alt="" width="345" height="444" />

We can do whatever we want with the column header now.<img class="alignnone size-full wp-image-529" title="10" src="/wp-content/uploads/2008/11/10.png" alt="" width="500" height="240" />

And, just as we'd expect, we get our new style.

<img class="alignnone size-full wp-image-530" title="111" src="/wp-content/uploads/2008/11/111.png" alt="" width="340" height="132" />


We can also apply a style to a particular column.

<pre language="xml" name="code">
&lt;wpfToolkit:DataGridTextColumn x:Name="FirstColumn" Header="Something" HeaderStyle="{StaticResource FrozenColumnHeaderStyle }" &gt;
</pre>

<img class="alignnone size-full wp-image-519" title="12" src="/wp-content/uploads/2008/11/12.png" alt="" width="414" height="93" /></div>
