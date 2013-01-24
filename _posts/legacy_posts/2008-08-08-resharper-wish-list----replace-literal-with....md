---
title: ReSharper Wish List -- Replace Literal With...
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



One thing I would love ReSharper to do for me is to replace a literal string with a local variable or constant and also refactor any other usings, optionally including internal usages, of the same string literal.

I would like for it to take:

<pre language="c#" name="code">
public string Foo(IDictionary&lt;string,string&gt; d){
 if(d.ContainsKey("foo")){
 return d["foo"];
 }
 return string.Empty;
}
</pre>
...and change it to:
<pre language="c#" name="code">
public string Foo(IDictionary&lt;string,string&gt; d){
 string key = "foo";
 if(d.ContainsKey(key)){
 return d[key];
 }
 return string.Empty;
}
</pre>
That sounds very doable to me, but maybe I'm not seeing the complexity. I know ReSharper has API's for creating your own custom context actions, but I haven't looked into that yet.
