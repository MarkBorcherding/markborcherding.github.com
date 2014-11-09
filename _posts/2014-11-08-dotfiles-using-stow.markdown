---
layout: post
title: Dotfiles Using Stow
published: true
categories: dotfiles
tags:
image: /assets/article_images/2014-11-08-dotfiles-using-stow/dots.jpg
image_credit: https://www.flickr.com/photos/dygatiqah/2337492290
---

There a lot of examples out there about how to manage dotfiles. There are also many examples out there on how to install them using custom shell scripts or other tools. I've tried plenty of them, but the one I found works best for me is [Stow](http://www.gnu.org/software/stow/).

 Stow will symlink the contents of a directory to another directory, which makes it ideal for installing dotfiles. Say you have the following directory.

 ```
 ~/
   └── source
       └── my_dotfiles
           └── dotfiles
               ├── .vimrc
               ├── .vim
               │   └── colors
               │       └── tomorrow-night.vim
               └── bash_completion.d
                   └── gem.completion.bash
```

If you were in `my_dotfiles` and run `stow -d $HOME dotfiles` it would symlink `.vimrc`, `.vim/`, and `bash_completion.d` into your `$HOME` directory. You can create _packages_ to better organize your dotfiles and also switch between work and personal settings, since `stow` has the ability to remove symlnks its managing.

Between that and a few shell scripts to install some software, I'm pretty _OK_ with [my dotfiles](https://github.com/MarkBorcherding/dotfiles)

