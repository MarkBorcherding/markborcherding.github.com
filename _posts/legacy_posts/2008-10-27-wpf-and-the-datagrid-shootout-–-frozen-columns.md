---
title: WPF and the DataGrid Shootout  Frozen Columns
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



My recent project has chosen WPF as its display technology. The biggest shortcoming of WPF for a traditional line of business application is its lack of a data grid control. Luckily there are several control providers out there that are already trying to meet this need; however we are attempting to determine how <em>closely </em>they meet our needs.

Our two most likely candidates are <a href="http://www.infragistics.com/">Infragistics</a> <a href="http://www.infragistics.com/dotnet/netadvantage/wpf/xamdatagrid.aspx#Overview">xamDataGrid</a> and <a href="http://www.telerik.com/">Telerik</a>s <a href="http://www.telerik.com/products/wpf/controls/radgridview/overview.aspx">radDataGrid</a>. The third contender, which unfortunately appears to be eliminated due to being open-source, is the data grid in the <a href="http://www.codeplex.com/wpf/Release/ProjectReleases.aspx?ReleaseId=14963">WPF Toolkit</a>. For some reason we are scared to death of open source tools. We would rather pay someone for closed source solution and be at their mercy to fix our problems than have it open and fix it ourselves. This could be an entire post on its own. Right now Im paying the most attention to XamDataGrid and the WPF Toolkit DataGrid, maintaining hope that well value something free if it provides us the value we need.

Anyway, our first out non-standard requirement is to freeze the column and row headers so we never scroll the first column or the headers to where they are no visible.

<a href="/wp-content/uploads/2008/10/image5.png"><img style="border-top-width: 0px; display: block; border-left-width: 0px; float: none; border-bottom-width: 0px; margin-left: auto; margin-right: auto; border-right-width: 0px" title="image" src="/wp-content/uploads/2008/10/image-thumb5.png" border="0" alt="image" width="273" height="207" /></a>

The column headers were simple. Both did that right out of the box. To freeze the first column with the WPF Toolkit datagrid requires setting one attribute:
<pre language="xml" name="code">&lt;Controls:DataGrid AutoGenerateColumns="False" Name="grid" FrozenColumnCount="1"&gt;</pre>
No problem.

For the Infragistics grid there appears to be a lot more code to write. According to <a href="http://forums.infragistics.com/forums/t/9003.aspx">a post on the Infragistics forum</a>, column <a href="http://news.infragistics.com/forums/t/910.aspx">freezing is not available with the Infragistics</a> grid. The people I have seen implementing it put two grids side-by-side and only allow one to scroll, and I assume manually scroll them vertically together.
