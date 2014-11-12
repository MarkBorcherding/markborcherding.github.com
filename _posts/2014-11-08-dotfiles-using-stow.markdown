---
layout: post
title: Dotfiles Using Stow
published: true
categories: dotfiles
tags: dotfiles
image: /assets/article_images/2014-11-08-dotfiles-using-stow/dots.jpg
image_credit: https://www.flickr.com/photos/dygatiqah/2337492290
---
There a lot of examples out there about how to manage dotfiles. There are also many examples out there on how to install them using custom shell scripts or other tools. They all have their ups and down.  I've tried plenty of them. I've also worked on complicated scripts with their own conventions to make sure things are symlinked properly, with the correct names, in the correct location.

I've found [Stow](http://www.gnu.org/software/stow/) works best for me.

<p class='shout'>
Stow will symlink one directory to another directory; making it ideal for installing dotfiles.
</p>

 Say you have the following directory.

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

If you run `stow --dir ~/source/my_dotfiles --target ~/ dotfiles` it would symlink `.vimrc`, `.vim/`, and `bash_completion.d` into your `$HOME` directory. You can create _packages_ to better organize your dotfiles and also switch between work and personal settings, since `stow` has the ability to remove symlnks its managing. Be sure to read up on the defaults, because some of those parameters might be redundant depending on where you run them and where you want things to go.

Stow doesn't do anything fancy with appending leading dots to files. It takes the files in the directory verbatim. Directories or files, it doesn't matter. It brings it all over to your target directory.

Between that and a few shell scripts to install some software, I'm pretty _OK_ with [my dotfiles](https://github.com/MarkBorcherding/dotfiles)

