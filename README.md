# better-defaults.vim

Think of better-defaults.vim as one step above [sensible.vim](https://github.com/tpope/vim-sensible): a better set of defaults that (almost) everyone can agree on.

The reasons to use it are the same that Tim Pope described in sensible.vim: this can your starting point for customization, a neutral territory for pair programming and you can simply `scp` it to any remote machine to make things a bit more tolerable.

## Installation

Install using your favorite package manager. For example, if you use vim-plug, just put the following line inside your plug-section:

    Plug 'Oliveiras/vim-better-defaults'

But, in the worst case, you may need to edit a file through an `ssh` connection to a remote machine which doesn't have internet access. Since this plugin consists of a single file, you can easily copy and source it, like this (assuming you have cloned or downloaded this repository):

    my-local-user@my-workstation:~ $ scp plugin/better-defaults.vim my-remote-user@remote-server:~/
    my-local-user@my-workstation:~ $ ssh my-remote-user@remote-server
    my-remote-user@remote-server:~ $ echo 'source ~/better-defaults.vim' >> .vimrc

## Features

This plugin merges the features of 3 sources:

* It has everything from [defaults.vim](https://github.com/vim/vim/blob/master/runtime/defaults.vim)
* It has everything from [sensible.vim](https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim)
* It has almost everything from [nvim-defaults](https://neovim.io/doc/user/vim_diff.html) (some things are not applicable to vim)

For some options, this sources are in conflict. In this cases, I decide which one to keep, favoring usefulness, instead of backward compatibility.

It also has some extra settings that people usually add to their init file, based on this survey made on 13759 vimrc files: https://github.com/rht/eigenvimrc:

* `set number`: Show line numbers. Also, if you didn't change the colorscheme, it will set the color of the line numbers to gray (because the default colorscheme uses the same color for line numbers and for syntax highlighting).
* `set ignorecase` and `set wildignorecase`: Ignore case for searches and file name completions.
* `set statusline`: If you didn't set a statusline, it will set one for you. In comparison with the built-in statusline, it adds the buffer number, file type, encoding, line ending format and current indentation (tabs or spaces and width).
If you have unicode support, you may like to change separators with: <br>
    `let g:default_statusline_left_separator = "  "` <br>
    `let g:default_statusline_right_separator = "  "`

### Disabling or overriding

If you installed better-defaults as a plugin, you can early-load it and then override any setting you want. This also applies if you have just copied and `source`d it. To early-load it, use:

    runtime! plugin/better-defaults.vim

Otherwise, you can disable the extra settings all at once with:

    let g:default_noset_extras = 1

Or you can disable one by one with:

    let g:default_noset_number = 1
    let g:default_noset_ignorecase = 1
    let g:default_noset_statusline = 1 

Also, better-defaults always try to do not override your settings, but this is not always possible. For example, it never adds a mapping if you have already mapped those keys.

Check the [Wiki](https://github.com/Oliveiras/vim-better-defaults/wiki) for a didactic explanation of what each option set does.

