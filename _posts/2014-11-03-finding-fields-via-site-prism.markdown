---
layout: post
title: Finding fields via Site&nbsp;Prism
published: true
categories: testing
tags: site_prism testing
image: /assets/article_images/siteprism.jpg
image_credit: https://www.flickr.com/photos/jakerome/3716459705
---

[Site Prism](https://github.com/natritmeyer/site_prism) has been really helpful with implementing the Page Model Pattern using Capybara. It's helped make our Cucumber steps more reusable and does a better job of describing what the page _should_ look like. Take for example the following page.

{% highlight ruby %}
class LoginPage < SitePrism::Page
  element :email, "#login_email"
  element :password, "#login_password"
  element :login_button, "input[type=submit]"
end
{% endhighlight %}

Pretty straightforward. Combine that with the awesome helpers you get from Site Prism, and that is a pretty great tool.

The bummer for me, is that we are selecting on a very _implementation-centric_ selector. From the perspective of a Cucmber test, it shouldn't matter what the name of the input is. The ID isn't a user-observable attribute; however the text in the label is, so lets use that.

After [a quick look at `SitePrism::Page`](https://github.com/natritmeyer/site_prism/blob/master/lib/site_prism/page.rb), it looks like it is just delegating down to Capybara's `#find`.  Capybara has [`#find_field` which also delegates to `#find`](https://github.com/jnicklas/capybara/blob/master/lib/capybara/node/finders.rb#L55). Looks like this should just work from Site Prism.

{% highlight ruby %}
class LoginPage < SitePrism::Page
  element :email, :field, 'Email Address'
  element :password, :field, 'Password'
  element :login_button, :button, 'Login'
end
{% endhighlight %}

Sure enough! It works. You can get fancier by using translations to find the fields, but opinions vary on if that is too far.
