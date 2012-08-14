---
title: ReSharper Tip of the Day -- Generate Equals
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



Weve all probably had really basic <a href="http://en.wikipedia.org/wiki/Plain_Old_CLR_Object">POCO</a> classes like this:

<pre name="code" class="c#">
public class Fooberry
{
    public string Foo { get; set; }
    public string Bar { get; set; }
}

</pre>

and weve probably had to override Equals on them. When I went to go do it this last time, I saw ReSharper was trying to help me out.

<img class="alignnone size-full wp-image-249" title="overrideequals" src="/wp-content/uploads/2008/08/overrideequals.jpg" alt="" width="371" height="62" />

So I expanded the context icon to see what it would do for me. It turns out it does something really cool.

<img class="alignnone size-full wp-image-251" title="contextactions" src="/wp-content/uploads/2008/08/contextactions.jpg" alt="" width="385" height="200" />

It will complete the Equals statement for me! Awesome! I hate writing that method over and over.

<img class="alignnone size-full wp-image-252" title="dialog" src="/wp-content/uploads/2008/08/dialog.jpg" alt="" width="442" height="337" />

YesI would like to compare those itemsand were done!

<pre name="code" class="c#">
public override bool Equals(object obj) {
    if (ReferenceEquals(null, obj)) return false;
    if (ReferenceEquals(this, obj)) return true;
    if (obj.GetType() != typeof (Fooberry)) return false;
    return Equals((Fooberry) obj);
}

public bool Equals(Fooberry obj)
{
    if (ReferenceEquals(null, obj)) return false;
    if (ReferenceEquals(this, obj)) return true;
    return Equals(obj.Foo, Foo) && Equals(obj.Bar, Bar);
}

public override int GetHashCode()
{
    unchecked
    {
        return ((Foo != null ? Foo.GetHashCode() : 0)*397) ^ (Bar != null ? Bar.GetHashCode() : 0);
    }
}
</pre>
Pretty awesome if you ask me! The only downside is if I add new members to the class, I need to either add the tests in manually or generate the whole thing.

Steve (a co-worker)'s sharp eye noticed the <a href="http://msdn.microsoft.com/en-us/library/a569z7k8.aspx">unchecked</a> keyword, and neither of us has used it so after looking it up it avoids overflow checks and trunks anything that would exceed normal bounds.
