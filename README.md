vim-scala [![Build Status](https://secure.travis-ci.org/lenniboy/vim-scala.png)](http://travis-ci.org/lenniboy/vim-scala)
==========

This is a "bundle" for Vim that builds off of the initial Scala plugin modules
by Stefan Matthias Aust and adds some more "stuff" that I find useful, including
all of my notes and customizations.

##Installation

You really should be using Tim Pope's [Pathogen](https://github.com/tpope/vim-pathogen) module for Vim (http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen) if you're going to clone this repository because, well... you should.

###Vundle
Alternatively, you can use [Vundle](https://github.com/gmarik/vundle) to
manage your plugins.

If you have Vundle installed, simply add the following to your .vimrc:

```vim
Bundle 'derekwyatt/vim-scala'
```

and then run

```vim
:BundleInstall
```

to install it.

##Sorting of import statements
    :SortScalaImports

There are different modes for import sorting available. For details, please
consult the vimdoc help with

    :help :SortScalaImports
