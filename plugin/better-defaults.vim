" better-defaults.vim - Defaults almost everyone can agree on
" Maintainer:   Alex Oliveira <https://github.com/Oliveiras>
" Version:      0.1
" License:      Vim License

set nocompatible

" SETUP VARIABLES {{{
" ------------------------------------------------------------------------------

" Load this file only once.
if exists('g:loaded_better_defaults')
    finish
else
    let g:loaded_better_defaults = 'yes'
endif

" Decide the location of data-dir
if ! exists('$XDG_DATA_HOME')
  if has('win32')
    let $XDG_DATA_HOME=$LOCALAPPDATA
  else
    let $XDG_DATA_HOME=$HOME . '/.local/share'
  endif
endif

" Decide the location of the backup directory.
if exists('g:default_backup_dir')
    " already set
elseif has('nvim')
    let g:default_backup_dir = $XDG_DATA_HOME . '/nvim/backup//'
elseif has('win32')
    let g:default_backup_dir = $HOME . '/vimfiles/backup//'
else
    let g:default_backup_dir = $HOME . '/.vim/backup//'
endif

" Decide left and right separator for status line.
if ! exists('g:default_statusline_left_separator')
    let g:default_statusline_left_separator = ' | '
endif
if ! exists('g:default_statusline_right_separator')
    let g:default_statusline_right_separator = ' | '
endif

if exists('g:default_noset_extras')
    let g:default_noset_number = 'yes'
    let g:default_noset_ignorecase = 'yes'
    let g:default_noset_statusline = 'yes'
endif

" }}}

" TERMINAL INTERACTION {{{
" ------------------------------------------------------------------------------

" Enable mouse support.
if has('mouse')
    set mouse=a
endif

" Use visual bell instead of beeping.
set visualbell

" Always assumes a fast terminal.
silent! set ttyfast

" Fix true-colors support when running inside tmux or screen.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
    set t_Co=16
endif

" }}}

" VISUAL ELEMENTS {{{
" ------------------------------------------------------------------------------

" Always show the status line.
set laststatus=2

" Show current cursor position in the status line.
set ruler

" Show (partial) commands in the command line.
set showcmd

" Show current mode in the command line.
set showmode

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
    set guioptions-=t
endif

" Show line numbers.
if ! exists('g:default_noset_number')
    set number

    " Line numbers call too much attention on default color scheme.
    if ! exists('g:colors_name')
        highlight LineNr ctermfg=gray guifg=gray
    endif
endif

" }}}

" COMMAND LINE {{{
" ------------------------------------------------------------------------------

" Enables enhanced mode of command-line completion.
set wildmenu

" Ignore case when completing file paths?
if ! exists('g:default_noset_ignorecase')
    set wildignorecase
endif

" Remember the last 1000 commands (at least).
if &history < 1000
    set history=1000
endif

" }}}

" LOADING, SAVING AND QUITTING {{{
" ------------------------------------------------------------------------------

" Reload files changed outside of vim.
set autoread

" Enable backup files (save previous version of modified files).
if (&writebackup)
    set backup

    " Save backups in a specific dir (not in the same dir as the original file).
    let &backupdir=g:default_backup_dir

    " Create backup directory, if it does't exist.
    if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
endif

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Show a dialog asking if you want to save before quit.
set confirm

" Save and restores global variables named in all-caps.
set viminfo+=!

" Don't save local (temporary) options and mappings.
set sessionoptions-=options
set viewoptions-=options

" }}}

" FILETYPE DETECTION AND SYNTAX HIGHLIGHTING {{{
" ------------------------------------------------------------------------------

" Enable file type detection.
if has('autocmd')
    filetype plugin indent on
endif

" Enable syntax highlighting.
if has('syntax')
    syntax enable
endif

" }}}

" BUFFERS AND WINDOWS {{{
" ------------------------------------------------------------------------------

" Allows switching from an unsaved buffer.
set hidden

" New windows appear on right or bottom.
set splitright
set splitbelow

" }}}

" SEARCHING {{{
" ------------------------------------------------------------------------------

" Use incremental search (a.k.a. search as you type).
set incsearch

" Highlight all matches of the last search.
set hlsearch

" Searches are case-insensitive by default
if ! exists('g:default_noset_ignorecase')
    set ignorecase
endif

" Searches are always case-sensitive if the pattern contains uppercase letters.
set smartcase

" }}}

" INDENTATION {{{
" ------------------------------------------------------------------------------

" Automatically indent new lines.
set autoindent

" Use <Tab> for indenting on INSERT mode.
set smarttab

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" }}}

" LINE WRAPPING {{{
" ------------------------------------------------------------------------------

" Should remove wrapping of text at the window boundary? (let the user decide)
" set nowrap

" But if wrapping is enabled, use word-wrap.
set linebreak

" }}}

" SCROLLING {{{
" ------------------------------------------------------------------------------

" Keep 1 extra line of context when scrolling up or down.
if !&scrolloff
    set scrolloff=1
endif

" Keep 5 extra columns of context when scrolling left or right.
if !&sidescrolloff
    set sidescrolloff=5
endif

" }}}

" STATUS LINE {{{
" ------------------------------------------------------------------------------

" Set the content of the status line.
if (&statusline == '') && ! exists('g:default_noset_statusline')
    " start with an empty line
    let &statusline=""
    " buffer number
    let &statusline.=" (%n)"
    " left separator
    let &statusline.=g:default_statusline_left_separator
    " file path
    let &statusline.="%<%f"
    " buffer flags
    let &statusline.=" %h%w%m%r"
    " spacing
    let &statusline.="%="
    " file type (syntax)
    let &statusline.="%y"
    " file encoding
    let &statusline.="[%{''.(&fenc!=''?&fenc:&enc).''}]"
    " file line-ending format
    let &statusline.="[%{&ff}]"
    " tabs or spaces
    let &statusline.="%{&modifiable?(&expandtab?'[spaces:':'[tabs:').&shiftwidth.']':''}"
    " right separator
    let &statusline.=g:default_statusline_right_separator
    " buffer position
    let &statusline.="%-12.(%l,%c%V%) %P "
endif

" }}}

" MAPPINGS {{{
" ------------------------------------------------------------------------------

" Maintain Visual Mode after shifting with > and <.
if maparg('<', 'x') ==# ''
    xnoremap < <gv
    xnoremap > >gv
endif

" Make Y behave like D and C (to the cursor position to end of line).
if maparg('Y', 'n') ==# ''
    nnoremap Y y$
endif

" Search for selected region with * and #.
if maparg('*', 'x') ==# ''
    xnoremap * "yy/<C-r>y<CR>
    xnoremap # "yy?<C-r>y<CR>
endif

" Don't let <C-U> and <C-W> delete too much on INSERT mode.
if maparg('<C-U>', 'i') ==# ''
    inoremap <C-U> <C-G>u<C-U>
    inoremap <C-W> <C-G>u<C-W>
endif

" Don't use Ex mode, use Q for formatting.
if maparg('Q', 'n') ==# ''
    nnoremap Q gq
endif

" Use <C-L> to clear the search highlighting.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" }}}

" OPTIONS OVERRIDE {{{
" ------------------------------------------------------------------------------

" When running in GUI mode, always set encoding to UTF-8.
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X.
set nrformats-=octal

" Don't look at included files when suggesting completions (it's too slow).
set complete-=i

" The langmap option won't be applied to characters resulting from a mapping.
if has('langmap') && exists('+langremap')
  set nolangremap
endif

" When the last line is too big to fit in the screen, show @@@ at the end.
set display+=lastline

" Delete comment character when joining commented lines.
silent! set formatoptions+=j

" Don't let cursor jump to start of line when changing buffers.
set nostartofline

" Don't put two spaces after punctuation when joining lines.
silent! set nojoinspaces

" Increase max open tabs to 50 (at least).
if &tabpagemax < 50
    set tabpagemax=50
endif

" }}}

" MISCELANEOUS {{{
" ------------------------------------------------------------------------------

" Characters to use for formatting the list mode.
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Search upwards for tags file.
if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Enable timeout of 1s for mapped key sequences and 100ms for key codes.
if !has('nvim') && &ttimeoutlen == -1
    set ttimeout
    set ttimeoutlen=100
endif

" Give messages when adding a cscope database.
if has('cscope')
    set cscopeverbose
endif

" }}}

