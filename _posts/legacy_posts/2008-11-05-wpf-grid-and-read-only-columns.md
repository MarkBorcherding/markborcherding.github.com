---
title: WPF Grid and Read Only Columns
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



In an attempt to provide a total summary column in a WPF data grid, I attempted to bind a read only column of a <code>DataTable</code> to a <code>DataGridTextColumn</code> of the <a href="http://www.codeplex.com/wpf">WPFToolkit</a> data grid. 

Initially, I tried to do the way I've been doing every other column.

<pre name="code" language="xml">
&lt;wpfToolkit:DataGridTextColumn 
     Header="Total" 
     DataFieldBinding="{Binding Total}"  />
</pre>

Unfortunately that gives us the following error:
<blockquote>
A TwoWay or OneWayToSource binding cannot work on the read-only property 'Total' of type 'System.Data.DataRowView'.</blockquote>

OK, that makes sense, we should just adjust the mode of the binding and try again.

<pre name="code" language="xml">
&lt;wpfToolkit:DataGridTextColumn 
     Header="Total" 
     DataFieldBinding="{Binding Total,Mode=OneWay}"  />
</pre>

....but we get the same error.  After a few quick Google searches, I found <a href="http://blogs.msdn.com/jaimer/archive/2008/08/13/dabbling-around-the-new-wpf-datagrid-part-1.aspx">someone else that already pointed out the issue and a possible workaround.</a> 



<blockquote><strong>ReadOnly columns</strong>  is missing from the CTP, but that is not a huge problem, you can easily accomplish ReadOnly behavior by using DataGridTemplateColumns and replacing the templates with read-only controls ( like TextBlocks).</blockquote>


 A quick change of the column to a <code>DataGridTemplateColumn</code> and it looks like we are off to the races. 

<pre name="code" language="xml">
&lt;wpfToolkit:DataGridTemplateColumn Header="Brand">
    &lt;wpfToolkit:DataGridTemplateColumn.CellTemplate>
        &lt;DataTemplate>
            &lt;TextBlock Text="{Binding Path=Brand,Mode=OneWay}" />
        &lt;/DataTemplate>
    &lt;/wpfToolkit:DataGridTemplateColumn.CellTemplate>
&lt;/wpfToolkit:DataGridTemplateColumn>
</pre>


<strong>NOTE:</strong> After another bit of searching on the web, the <a href="http://www.codeplex.com/wpf/Release/ProjectReleases.aspx?ReleaseId=15598">WPF Toolkit - October 2008</a> was released last week. This negates the need for the workaround for read only columns.

<pre name="code" language="xml">
&lt;wpfToolkit:DataGridTextColumn 
     Header="Total" 
     Binding="{Binding Total}" 
     IsReadOnly="True" />
</pre>
