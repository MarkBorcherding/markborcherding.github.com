---
layout: post
title: Assignment and Then Some
published: true
categories: ruby
tags: ruby
# image: /assets/article_images/2014-12-12-assignment-and-then-some
# image_credit:
---

# Assignment & Then Some

I recently ran across a rather odd looking bit of Ruby while browsing the [Database Cleaner readme](https://github.com/DatabaseCleaner/database_cleaner#how-to-use).

```ruby
DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
```

That looks really wierd to me. Assignment, with some additional parameters. Odd, but after looking at it, it makes sense what they are doing.

```ruby
def strategy=(args)
  arg, *params = args
  puts "#{arg} with some params of #{params}"
end
```

Neat, but I don't know if I like it when using the `=` operator. For one thing, the params _must_ be enclosed in `{}`.

<p class='shout'>
Besides that, it just looks really wierd.
</p>

While a clever trick to add some additional information to an attribute, I find it confusing, but I don't really have a bettersolution.
