---
layout: post
title: "Per Project .vimrc to save the day"
description: ""
---

As I've been mentioning, I'm working on a Trigger.io project. Things have been going great except one thing.
It copies files around the project directory as you build your project for multiple platforms. Here is what
NERDTree looks like in my Vim.

    ▸ app/                   <-- My AngularJS app files
    ▸ bin/                   <-- Some scripts to help run other tasks
    ▾ development/           <-- Holds copies of the build src dir
      ▸ android/             <--  ....for android
      ▸ ios/                 <--    ....and ios
      ▸ web/                 <--      ....and the web
    ▸ node_modules/          <-- All the NodeJS bits I'm using
    ▸ release/               <-- Packaged apps for each platform
    ▸ src/                   <-- My actual source files
    ▸ test/                  <-- My Tests

So I care about three of those directories: `app`, `src`, and `test`. To some extent I care about `bin`,
but the others I don't really care about. Now I don't use NERDTree that much. It's nice and useful, but
the _more_ useful plugin for me is [CtrlP](https://github.com/kien/ctrlp.vim).

CtrlP is awesome. I love it, but with 4 copies of my source, I'm constantly selecting the wrong version
of my file. I wanted to ignore them from both CtrlP and NERDTree, but I don't want to _always_ ignore
`development`. Luckily my buddy turned me onto a possible solution; Per-project `.vimrc` files.

There are plent of articles on the Google that will help you set it up, but
[here](http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/)'s what I did and is so far working great.

I added this to my `~/.vimrc`:

{% highlight  vim %}
    set exrc            " enable per-directory .vimrc files
    set secure          " disable unsafe commands in local .vimrc files
{% endhighlight %}

 Then added this to my `.vimrc` in the project directory:

{% highlight  vim %}
    let g:ctrlp_custom_ignore = '\v[\/](release|node_modules|development)$'           " Ignores for CtrlP
    let NERDTreeIgnore=['development$', 'node_modules$', 'release$', '\.vim$', '\~$'] " Ignores for NERDTree
{% endhighlight %}

That's it. It works great. CtrlP is now always getting the right file and NERDTree has a lot less noise.
