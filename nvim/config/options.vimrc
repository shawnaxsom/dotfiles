" -----------------------------------------------------------------------------------------
"  Options
" -----------------------------------------------------------------------------------------

" Don't use swap or backup files
set noswapfile
set nobackup
set nowritebackup

" Ability to undo after closing Vim
set undofile
set undolevels=5000

" Update buffer if file changes outside of Vim, without prompt
set autoread
" au CursorHold * checktime

" Don't wrap normally
set nowrap

" If you enable wrap, break on spaces or tabs
set linebreak
set breakat=\ ^I

" Don't change directory to current buffer.
" Some plugins don't work with this enabled, like vimfiler or vimshell
set noautochdir

" Show tabs, trailing characters as periods, but not in e.g. help files
augroup listchars
  autocmd!
  autocmd FileType javascript.jsx setlocal list
  autocmd FileType javascript.jsx setlocal listchars=tab:>.,trail:.,extends:#,nbsp:.
augroup END

" Keep windows at a good size
set winheight=10
set winwidth=90
set winminwidth=25
set winminheight=3
" set winheight=3
" set winwidth=90
" set winminwidth=25
" set winminheight=3

" If you open up gVim for whatever reason
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" allow cursor to stay in same column while scrolling
set virtualedit=all
set nostartofline

" allow copy/paste using system clipboard (otherwise have to use "+)
" set clipboard=unnamed
set clipboard=unnamed,unnamedplus

" The basics
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent

" Allow backspace to go past beginning of line
set backspace=indent,eol,start

" Keep cursor centered -- this is choppy if scrolling multiple splits
set scrolloff=12
set sidescrolloff=5

" Use Bash shell syntax for :! (even if you are in Fish or ZSH)
set shell=bash

" Use MORE as pager
set more

" Don't redraw screen when using a macro or register
set lazyredraw

" Improve smoothness of redrawing
set ttyfast

" Send the current mouse codes over when clicking
" set ttymouse=xterm
set mouse=a

" When closing off brackets, briefly show the matching bracket
set noshowmatch

" Default to splitting in the bottom and left
set splitbelow
set splitright

" Default substitute to s//g
set gdefault

" If doing :q with unsaved changes, ask to quit, rather than just failing
set confirm

" Vertically split diffs with vimdiff
set diffopt=vertical

" Allow background buffers (e.g. edit another file while current file still
" has changes to save)
set hidden

" Command history
set history=1000

" Don't insert two spaces after a join command
set nojoinspaces

" Line numbers
set number
set relativenumber
set numberwidth=6

" Wildmenu completion mentu when pressing tab
set wildcharm=<TAB>
set wildmenu
" set wildmode=list,full
" set wildmode=full:list
set wildmode=full
set wildchar=<Tab>

" Search settings
set incsearch
set hlsearch
set noignorecase              " affects both searching and find/replace
set smartcase
set nowrapscan                  " Wrap to top of file after searching through full file

" Fold settings
set foldmethod=indent
set foldnestmax=8
set foldlevelstart=999

" Don't show tab bar
set showtabline=0

" Change CWD while navigating in NetRW.
let g:netrw_keepdir=0
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Auto indent settings
filetype plugin indent on
set autoindent
set smartindent

" Allow the :find command to search current directory recursively for a file
" E.g. :find myfile.text
" https://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim
" NOTE: Add additional paths in .vimrc
set path=.,/usr/include,,

" Allow gf to find JavaScript file references without extension
set suffixesadd=.js,.jsx

" Set window title to include current filename.
" or use in iterm2: press cmd+shift+o and search for filename of a window
set t_ts=]1;
set t_fs=
set title
set titlestring=vim\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Fix Vim background in Tmux, don't break colors at end of line.
set t_ut=
set t_Co=256
let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"


" Use space button for leader
let mapleader = "\<Space>"

" How long leader key and other key combinations will wait for another key
" NOTE: Usually the timeout shouldn't be needed for <leader> / <space> in
" insert mode. If you start having this timeout apply, something must have set
" up imap <space> or something similar. Use this to debug:
" :verbose imap <space>
set timeoutlen=800
set ttimeoutlen=0

" Minimize how often you see "Press enter or type a command to continue"
set shortmess=a
set cmdheight=3

" Allow completion of tags using omnicompletion <c-x><c-o>
set omnifunc=htmlcomplete#CompleteTags

" Don't let netrw be included when doing <c-^>
let g:netrw_altfile = 1

" Tell vim to remember certain things when we exit,
" including oldfiles history length
"  '250  :  MRU / :oldfiles - marks will be remembered for up to 10 previously edited files
"  "100  :  will save up to 100 lines for each register
"  :100  :  up to 20 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
if has('nvim')
  set shada='250,\"100,:100,n~/.vim/shada
else
  set viminfo=\'250,\"100,:100,%
endif

" -----------------------------------------------------------------------------------------
"  Neovim specific settings
" -----------------------------------------------------------------------------------------
" Show interactive preview of substitute changes when using :%s///
set inccommand=split
