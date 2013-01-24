---
title: NHibernate and Correlated Subqueries
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



We needed to select elements from an entity and also multiple sums of elements from its child entities. If we wanted to do it in pure SQL, we could issue the following SQL.
<pre name="code" class="sql">select company_name,
       (select sum(payment_amount)
          from payments p
         where p.company_id = c.company_id)
       (select sum(invoiced_amount)
          from invoices i
         where i.company_id = c.company_id)
from company c
group by c.company_name</pre>
However, we wanted to try and issue it using NHibernate and its criteria model. What makes this difficult is the two correlated sub queries. If we needed only one sum, a simple projection with an outer join would work. With the second sum, that gives incorrect results.

I found brief <a href="http://www.hibernate.org/hib_docs/nhibernate/1.2/reference/en/html/querycriteria.html#querycriteria-detachedqueries">NHibernate documentation about correlated sub queries</a>. Additional documentation stated they are allowed in the "<code>where</code>", but not in the "<code>from</code>" and aren't needed in the "<code>select</code>" because of <a href="http://www.hibernate.org/hib_docs/nhibernate/1.2/reference/en/html_single/#mapping-declaration-property">derived properties</a>. I've lost the link to the blog article that led me to that.

The mapping for the derived property would look something like this:
<pre name="code" class="xml">
&lt;property 
          name    ="TotalPayments"    
          insert  ="false" 
          update  ="false" 
          access  ="nosetter.camelcase"
          type    ="Decimal"
          formula ="(select nvl(SUM(NVL(p.PAYMENT_AMOUNT,0)),0) 
                       from payments p 
                      where p.COMPANY_ID = COMPANY_ID)" /&gt;
</pre>
What is interesting to note here is that everything in the <code>formula</code> uses real SQL and database identifiers, not entity attributes and HQL.

Now that we have the mapping created, we need something for it to map to. A simple read-only property will do.
<pre name="code" class="csharp">
private decimal totalPayments;
public virtual decimal TotalPayments
{
     get { return totalPayments; }
}
</pre>
 
That's it. If we do a simple test using a projection we can see the SQL that it's outputting and see it gives us exactly what we want.

One thing to note is the property is <b>NOT</b> affected by changes made to the entity. If we add payments using the domain, it will not appear in this total. This is OK since we want it mostly for reporting, and we could probably even map the property to the field and make it private or protected to avoid the confusion to the consumers of the domain.
