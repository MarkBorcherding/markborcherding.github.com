---
layout: page
title: Hello World!
tagline: Supporting tagline
---
{% include JB/setup %}
Read [Jekyll Quick Start](http://jekyllbootstrap.com/usage/jekyll-quick-start.html)

Complete usage and documentation available at: [Jekyll Bootstrap](http://jekyllbootstrap.com)

# The Battle for Endor

But with the blast shield down, I can't even see! How am I supposed to fight? The more you tighten your grip, Tarkin, the more star systems will slip through your fingers. No! Alderaan is peaceful. We have no weapons. You can't possibly…


## Example syntax

{% highlight ruby %}
def foo
  hook :orm
  "return #{string}"
end
{% endhighlight %}

## A New Hope

I'm surprised you had the courage to take the responsibility yourself. She must have hidden the plans in the escape pod. Send a detachment down to retrieve them, and see to it personally, Commander. There'll be no one to stop us this time! Look, I can take you as far as Anchorhead. You can get a transport there to Mos Eisley or wherever you're going. What?! A tremor in the Force. The last time I felt it was in the presence of my old master. A tremor in the Force. The last time I felt it was in the presence of my old master.

* The more you tighten your grip, Tarkin, the more star systems will slip through your fingers.
* I'm surprised you had the courage to take the responsibility yourself.
* You mean it controls your actions?



## More

In `_config.yml` remember to specify your own data:

    title : My Blog =)

    author :
      name : Name Lastname
      email : blah@email.test
      github : username
      twitter : username

The theme should reference these variables whenever needed.

## Sample Posts

This blog contains sample posts which help stage pages and blog data.
When you don't need the samples anymore just delete the `_posts/core-samples` folder.

    $ rm -rf _posts/core-samples

Here's a sample "posts list".

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

## To-Do

This theme is still unfinished. If you'd like to be added as a contributor, [please fork](http://github.com/plusjade/jekyll-bootstrap)!
We need to clean up the themes, make theme usage guides with theme-specific markup examples.


