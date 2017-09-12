" {{{ Options

" Don't use swap or backup files
set noswapfile
set nobackup
set nowritebackup

" No undodir, don't undo past last close
set noundofile

" Update buffer if file changes outside of Vim, without prompt
set autoread

" Don't wrap normally
set nowrap

" If you enable wrap, break on spaces or tabs
set linebreak
set breakat=\ ^I

" Don't change directory to current buffer.
" Some plugins don't work with this enabled, like vimfiler or vimshell
set noautochdir
set nolist

" Don't fully collapse windows when doing <c-w>_ or <c-w>|
set winheight=5
set winwidth=30
set winminwidth=30
set winminheight=5

" If you open up gVim for whatever reason
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" allow cursor to stay in same column while scrolling
set virtualedit=all
set nostartofline

" allow copy/paste using system clipboard (otherwise have to use "+)
if $TMUX == ''  " disable in TMux as it breaks copy / paste and is not needed
  set clipboard=unnamed
else
  set clipboard^=unnamed
endif

" The basics
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent

" Allow backspace to go past beginning of line
set backspace=indent,eol,start

" Keep cursor centered -- this is choppy if scrolling multiple splits
set scrolloff=3

" Use Bash shell syntax for :! (even if you are in Fish or ZSH)
set shell=bash

" Use MORE as pager
set more

" Don't redraw screen when using a macro or register
set lazyredraw

" Improve smoothness of redrawing
set ttyfast

" Send the corrent mouse codes over when clicking
set ttymouse=xterm2

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
set wildmode=list,full
set wildchar=<Tab>

" Always show the statusline
set laststatus=2

" Statusline (if Airline is not loaded)
set statusline=%f
set statusline+=%=        " Switch to the right side
set statusline+=%#warningmsg#

" Search settings
set incsearch
set hlsearch
set noignorecase              " affects both searching and find/replace
set smartcase
set wrapscan                  " Wrap to top of file after searching through full file

" Fold settings
set foldmethod=indent
set foldnestmax=8
set foldlevelstart=999

" Don't show tab bar
set showtabline=0

" Change CWD while navigating in NetRW.
let g:netrw_keepdir=1
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Auto indent settings
filetype plugin indent on
set autoindent
set smartindent

" Allow the :find command to search current directory recursively for a file
" E.g. :find myfile.text
" https://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim
set path+=**

" Allow gf to find JavaScript file references without extension
set suffixesadd=.js,.jsx

" Set window title to include current filename.
" or use in iterm2: press cmd+shift+o and search for filename of a window
set t_ts=]1;
set t_fs=
set title

" Fix Vim background in Tmux, don't break colors at end of line.
set t_ut=
set t_Co=256

" Use space button for leader
let mapleader = "\<Space>"

" How long leader key and other key combinations will wait for another key
" NOTE: Usually the timeout shouldn't be needed for <leader> / <space> in
" insert mode. If you start having this timeout apply, something must have set
" up imap <space> or something similar. Use this to debug:
" :verbose imap <space>
set timeoutlen=1500
" set ttimeoutlen=0

" }}}

" {{{ Plugins
call plug#begin('~/.vim/bundle')
" -----------------------------------------------------------------------------------------
" 1 - Essential
" -----------------------------------------------------------------------------------------
" {{{ CtrlP
Plug 'ctrlpvim/ctrlp.vim'
nnoremap <silent> <c-f> :CtrlPLine<CR>
if executable('rg')
  set grepprg=rg
  let g:ctrlp_user_command = 'rg %s --files --color=never --ignore-file ~/.agignore --glob ""'
  let g:ctrlp_use_caching = 0
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-ignore ~/.agignore -g ""'
  let g:ctrlp_use_caching = 0
elseif executable('ack')
  set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
endif

" let g:ctrlp_cmd = 'CtrlPMRU'
" let g:ctrlp_cmd = 'CtrlPBookmarkDir'
" let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_use_caching = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_default_input = 0
let g:ctrlp_types = ['buf', 'mru', 'fil']
let g:ctrlp_mruf_exclude = '.*/temp/.*' " MacOSX/Linux
let g:ctrlp_mruf_relative = 1

" let g:ctrlp_extensions = ['line', 'changes', 'bookmarkdir']
let g:ctrlp_extensions = ['']
" Using ag is faster, BUT wildignore doesn't work
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_use_caching = 0
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rst|pyc)$'
" set wildignore+=env/,node_modules/,dist/,bower_components/,tmp/,jest/
set wildignore+=env/,dist/,bower_components/,tmp/,jest/
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*__Scratch__ " scratch.vim
" }}}
" {{{ Fugitive / Extradite
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'  " Adds :Gbrowse to Fugitive for jumping to the Github repo
Plug 'int3/vim-extradite'
map <leader>gc :Gcommit<CR>i
map <leader>gp :Gpull<CR>
map <leader>gP :Gpush<CR>
map <leader>ge :Gedit<CR>
map <leader>gs :Gstatus<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gR :Gread<CR>
map <leader>gw :Gwrite<CR>
map <leader>gh :Gbrowse<CR>
map <leader>gl :Extradite<CR>
map <leader>gL :Glog<BAR>:bot copen<CR>
" augroup gitlog
"   autocmd!
"   autocmd FileType git nmap J /diff<CR> | nmap K k?diff<CR>
" augroup END
" autocmd! BufRead,BufNewFile fugitive* git nmap <leader>J /diff<CR>
" }}}
" {{{ GitGutter
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_highlight_lines = 0
" }}}
" {{{ Vim-Signature
" Show markers in gutter
" Plug 'kshenoy/vim-signature'
" }}}
" {{{ Vimux / Dispatch
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'  "  Run external commands in a small split Tmux pane
let g:VimuxHeight = "20"
let g:VimuxPromptString = "Vimux>  $ "
map ,v :call VimuxPromptCommand("npm start")<CR>
" Dispatch is better for single tasks, shows quickfix results afterwards
map ,d :Dispatch<SPACE>
map ,i :call VimuxInspectRunner()<CR>
" map ,z :VimuxZoomRunner<CR>
" map ,r :call VimuxPromptCommand("npm start")<CR>
" map ,r :Dispatch npm start<CR>
map ,r :call VimuxRunCommand("npm start")<CR>
" map ,q :call VimuxPromptCommand("env NODE_ENV=qa npm start")<CR>
" map ,q :Dispatch env NODE_ENV=qa npm start<CR>
map ,q :call VimuxRunCommand("env NODE_ENV=qa npm start")<CR>
augroup vimux
  autocmd!
  autocmd BufEnter */api/* map <buffer> ,q :call VimuxRunCommand("npm run build; and env NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,t :call VimuxRunCommand("npm test -- --tests " . expand("%"))<CR>
map ,t :Dispatch npm test<CR>
augroup END
map ,c :call VimuxInterruptRunner()<CR>
map ,t :Dispatch npm test<CR>
map ,f :Dispatch npm test -- --tests %
map ,b :Dispatch npm run build<CR>
" map ,z :Copen<CR>
map ,z :VimuxZoomRunner<CR>
" }}}
" {{{ vim-tmux-navigator
" Ctrl + J/K/H/L to move to different Vim or Tmux panes.
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 2
" }}}
" {{{ UltiSnips
Plug 'SirVer/ultisnips'
nmap <leader><leader>s :UltiSnipsEdit<CR>
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit="vertical"
" }}}
" {{{ YouCompleteMe
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer'  }
let g:ycm_show_diagnostics_ui = 1
let g:ycm_log_level = 'debug'
let g:ycm_cache_omnifunc = 1
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py'  }
" These don't work as well as tern_for_vim
" nmap <silent> gd :YcmCompleter GoTo<CR>
" nmap <silent> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" {{{ vim-polyglot
" Collection of language plugins.
" Includes: 'pangloss/vim-javascript'
" Includes: 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
let g:javascript_conceal_function                  = "ƒ"
let g:javascript_conceal_null                      = "ø"
let g:javascript_conceal_this                      = "@"
let g:javascript_conceal_return                    = "◁"
let g:javascript_conceal_undefined                 = "¿"
let g:javascript_conceal_NaN                       = "ℕ"
let g:javascript_conceal_prototype                 = "¶"
let g:javascript_conceal_static                    = "•"
let g:javascript_conceal_super                     = "Ω"
let g:javascript_conceal_arrow_function            = "➜"
let g:javascript_conceal_noarg_arrow_function      = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
" }}}
" {{{ Workspace
Plug 'thaerkh/vim-workspace'
nmap <leader><leader>w :ToggleWorkspace<CR>
nmap <leader>C :CloseHiddenBuffers<CR>
" Don't enable at the same time as vim-better-whitespace or it messes up
" search when autosave happens
let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave = 0
" No .undodir
let g:workspace_persist_undo_history = 0
" }}}

" -----------------------------------------------------------------------------------------
" 2 - Great
" -----------------------------------------------------------------------------------------
" {{{ Surround
Plug 'tpope/vim-surround'
vmap s <Plug>VSurround
nmap s viw<Plug>VSurround
nmap S v$h<Plug>VSurround
" }}}
" {{{ CtrlSF
Plug 'dyng/ctrlsf.vim'
map <F3> :CtrlSF -R ""<LEFT>
nmap <leader>8 "hyiw:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
nmap <leader>/ :CtrlSF -R ""<LEFT>
nmap <leader><leader>/ :CtrlSF -R "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" }}}
" {{{ Quickfix-Reflector
" Edit files within any quickfix window, then save to dynamically update files
" Works very similar to CtrlSF, but with quickfix rather than own window
Plug 'stefandtw/quickfix-reflector.vim'
" }}}
" {{{ vim-simple-todo
Plug 'vitalk/vim-simple-todo'  " Shortcuts to creating todo lists
let g:simple_todo_map_keys = 0
" map gs :topleft 12split ~/.scratch<CR>
map gs :topleft split ~/.scratch<CR>
augroup simpletodo
  autocmd!
  autocmd BufEnter   .scratch nmap <buffer> [[ <Plug>(simple-todo-new-start-of-line)i
  autocmd BufEnter   .scratch nmap <buffer> ,i <Plug>(simple-todo-new-start-of-line)i
  autocmd BufEnter   .scratch nmap <buffer> ,o <Plug>(simple-todo-below)
  autocmd BufEnter   .scratch nmap <buffer> x <Plug>(simple-todo-mark-switch)
  autocmd BufEnter   .scratch nmap <buffer> X :%g/\[x\]/d<CR>
  " autocmd BufEnter .scratch imap <buffer> [[ :norm o<CR><Plug>(simple-todo-new)i
  " autocmd BufEnter .scratch imap <buffer> ,i :norm o<CR><Plug>(simple-todo-new)i
  " autocmd BufEnter .scratch imap <buffer> ,o :norm o<CR><Plug>(simple-todo-new)i
  autocmd BufEnter   .scratch imap <buffer> [[ <Plug>(simple-todo-new)
  autocmd BufEnter   .scratch imap <buffer> ,i <Plug>(simple-todo-new)
  autocmd BufEnter   .scratch imap <buffer> ,o <Plug>(simple-todo-new)
  autocmd BufLeave   .scratch w
  autocmd BufEnter   .scratch abbreviate <buffer> [ [ ]
  autocmd BufRead    .scratch setlocal foldlevel=0
augroup END
" }}}
" {{{ Codi
Plug 'metakirby5/codi.vim'  " Interactive scratch pad, similar to Quokka
nmap <leader><leader>c :Codi!!<CR>
map <leader>c :bd<CR>
let g:codi#aliases = {
      \ 'javascript.jsx': 'javascript',
      \ }
" }}}
" {{{ Commentary
" Comment out a line of code with <c-/>
Plug 'tpope/vim-commentary'
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary
" }}}
" {{{ vim-better-whitespace
" Strip trailing whitespace on save
" Plug 'ntpeters/vim-better-whitespace'
" autocmd BufEnter * EnableStripWhitespaceOnSave
" }}}
" {{{ vim-paste-easy
" Automatically :set paste when it detects the very fast typing that occurs
" when pasting
Plug 'roxma/vim-paste-easy'
" }}}
" {{{ GoldenView
" Auto resize windows when switching windows
" Plug 'zhaocai/GoldenView.Vim'
" let g:goldenview__enable_default_mapping = 0
" " nmap <silent> <C-S>  <Plug>GoldenViewSplit
" " nmap <silent> <leader>m   <Plug>GoldenViewSwitchMain
" " nmap <silent> <leader><leader>m <Plug>GoldenViewSwitchToggle
" " nmap <silent> <C-N>  <Plug>GoldenViewNext
" " nmap <silent> <C-P>  <Plug>GoldenViewPrevious
" }}}
" {{{ Vim Deus (colorscheme)
Plug 'ajmwagar/vim-deus'
" }}}
" {{{ vim-indent-object
" Indentation object: cai, cii, vai, vii, dai, dii, etc.
" Also: aI to select one line above and below, to get e.g. an HTML tag name.
Plug 'michaeljsmith/vim-indent-object'
" }}}
" {{{ Eunuch
" Commands like :Rename, :Delete, :Mkdir, :Find
Plug 'tpope/vim-eunuch'
" }}}
" {{{ Vim-Repeat
" Repeat more sensible commands with .
Plug 'tpope/vim-repeat'
" }}}
" {{{ Neoformat (Prettier)
Plug 'sbdchd/neoformat'
let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--trailing-comma all', '--no-bracket-spacing'],
            \ }
            " \ 'args': ['--trailing-comma all', '--no-bracket-spacing', '--single-quote', '--no-semi'],
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_verbose = 0
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * Neoformat! javascript prettier
" augroup END
" augroup fmt
"   autocmd!
"   autocmd BufWritePre  *.js Neoformat! javascript prettier
" augroup END
" Neoformat when pressing =
nmap <silent> = :Neoformat<CR>
" Have Neoformat use &formatprg as a formatter
let g:neoformat_try_formatprg = 1
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" Don't be annoying with the 'no change was necessary' messages
let g:neoformat_only_msg_on_error = 1
" }}}
" {{{ ALE
" " Plug 'w0rp/ale'  " Async linting
" let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
" let g:ale_javascript_eslint_use_global = 1
" let g:ale_fixers = {
"       \   'javascript': [
"       \       'eslint'
"       \   ],
"       \}
" }}}
" {{{ NERDTree
Plug 'scrooloose/nerdtree'  " File browsing with :E . or :NERDTreeFind
Plug 'Xuyuanp/nerdtree-git-plugin'
" autocmd VimEnter * NERDTree
let g:NERDTreeMinimalUI        = 1
let g:NERDTreeShowBookmarks    = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeDirArrows        = 1
let g:NERDTreeQuitOnOpen       = 0
" augroup nerdtree
"   autocmd!
"   autocmd BufRead NERD_tree_* python map ,r :Dispatch python %:p<CR>
" augroup END
" function! ToggleNERDTreeFind()
"   if g:NERDTree.IsOpen()
"     execute ':NERDTreeClose'
"   else
"     " execute ':NERDTreeFind'
"     " execute ':NERDTree'
"     execute ':NERDTreeFind'
"   endif
" endfunction
" noremap _ :e %:p:h<CR>
" noremap _ :NERDTreeClose<CR>
" noremap - :call ToggleNERDTreeFind()<CR>
noremap - :NERDTreeFind<CR>
" noremap - :NERDTree<CR>
" noremap - :topleft NERDTree<CR>
" noremap _ :NERDTree<CR>
map <leader><leader>b :Bookmark<space>
" }}}
" {{{ yankstack
Plug 'maxbrunsfeld/vim-yankstack'  " Clipboard history by repeating <leader>p, was still remapping s key when I told it not to
let g:yankstack_map_keys = 0
" Remove S as a yank key, otherwise interferes with vim surround S in visual
let g:yankstack_yank_keys=['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" }}}

" -----------------------------------------------------------------------------------------
" 3 - Decent
" -----------------------------------------------------------------------------------------
" {{{ Airline / Lightline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let s:prevcountcache=[[], 0]
" function! ShowCount()
"     let key=[@/, b:changedtick]
"     if s:prevcountcache[0]==#key
"         return s:prevcountcache[1]
"     endif
"     let s:prevcountcache[0]=key
"     let s:prevcountcache[1]=0
"     let pos=getpos('.')
"     try
"         redir => subscount
"         silent %s///gne
"         redir END
"         let result=matchstr(subscount, '\d\+')
"         let s:prevcountcache[1]=result
"         return result
"     finally
"         call setpos('.', pos)
"     endtry
" endfunction
" set ruler
" let &statusline='%{ShowCount()} %<%f %h%m%r%=%-14.(%l,%c%V%) %P'
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
" let g:airline_theme='minimalist'
let g:airline_theme='deus'
" let g:airline_theme='hybrid'
" let g:airline_section_a = '%{substitute(expand("%:p:h"), getcwd(), "", "")}'
let g:airline_section_a = '%{expand("%:p:t")}'
" let g:airline_section_b = '/%{split(substitute(expand("%:p:h"), getcwd(), "", ""), "/")[0]}'
" let g:airline_section_c = '%{substitute(substitute(expand("%:p"), getcwd(), "", ""), "/" . split(substitute(expand("%:p:h"), getcwd(), "", ""), "/")[0], "", "")}'
let g:airline_section_b = '%{expand("%:p:h:t")}'
let g:airline_section_c = '%{expand("%:p:h:h:t")}'
" let g:airline_section_c = '%{join(split(expand("%:p", 1), "/")[0])}'
" let g:airline_section_c = '%{getcwd()}'
" let g:airline_section_c = '%{substitute(substitute(expand("%:p:h"), getcwd(), "", ""), "/" . split(substitute(expand("%:p:h"), getcwd(), "", ""), "/")[0], "", "")}'
let g:airline_section_x = ''
let g:airline_section_y = ''
" let g:airline_section_z = '%{ShowCount()}'
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline_inactive_collapse = 0
" let g:AutoPairsShortcutToggle = '<c-a>'
" }}}
" {{{ vim-smooth-scroll
Plug 'terryma/vim-smooth-scroll'
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 15, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 15, 2)<CR>
" }}}
" {{{ vim-sleuth
" Auto set file tab settings based on current file or other files in directory
Plug 'tpope/vim-sleuth'
" }}}
" {{{ matchit
" Use % to match HTML tags
Plug 'tmhedberg/matchit'
" }}}
" {{{ vim-colorschemes
" Big bundle of colorschemes to play with
Plug 'flazz/vim-colorschemes'
" }}}
" {{{ incsearch
" Extended search and fuzzy search
" Fuzzy search allows you to exclude spaces and such
" While searching, <c-j> can go to next PAGE of matches before pressing enter
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
" }}}
" {{{ EasyMotion
" Plug 'easymotion/vim-easymotion'
" nmap s <Plug>(easymotion-bd-w)
" let g:EasyMotion_smartcase = 1
" }}}
" {{{ vim-visual-star-search
" Allow you to use * and # on visually selected text
Plug 'nelstrom/vim-visual-star-search'
" }}}
" {{{ Clever-F
" The f key will reuse f and F to go next, instead of ; and ,
" Also, jumps to the next line if no more matches on current line
Plug 'rhysd/clever-f.vim'
" {{{ Targets
" daa - delete an argument
" Plug 'wellle/targets.vim'
" }}}
" }}}
" {{{ Grepper
" Use Ag to search using :GrepperAg, and :copen when finished
" CtrlSF is an alternative, but that doesn't allow :cnext or immediate search
Plug 'mhinz/vim-grepper'
map <F3> :GrepperAg ""<LEFT>
" nmap <leader><leader>8 "hyiw:GrepperAg <c-r>h<CR>:nohlsearch<CR>
" nmap <leader>/ :GrepperAg ""<LEFT>
" nmap <leader><leader>/ :GrepperAg "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" Search only open buffers
function! ToggleGrepperBuffersMode()
  if g:grepper.buffers
    let g:grepper.buffers = 0
    echo "Grepper will search all files"
  else
    let g:grepper.buffers = 1
    echo "Grepper will search only open buffers"
  endif
endfunction
map <leader><leader>b :call ToggleGrepperBuffersMode()<CR>
nmap gr "hyiw:GrepperAg <c-r>h<CR>
" nmap gi :GrepperAg '%{expand("%:p:t:r")}'<CR>
nmap gi :GrepperAg %:p:t:r<CR>
" map <F4> "hyiw:GrepperAg <c-r>h<CR>
let g:grepper = {}
runtime autoload/grepper.vim
let g:grepper.jump = 1
let g:grepper.stop = 500
" }}}
" {{{ tern_for_vim
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
" nmap <silent> gd :TernDef<CR>
nmap <silent> gt :TernDef<CR>
nmap <silent> gD :TernDef<CR>
" }}}
" {{{ Dash.app
Plug 'rizzatti/dash.vim'
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = {
      \ 'javascript' : [ 'javascript', 'react', 'materialui', 'rxjs', 'lodash', 'css' ]
      \ }
" }}}
" {{{ Vim Trailing Whitespace
Plug 'bronson/vim-trailing-whitespace'
" }}}
" {{{ winresizer
Plug 'simeji/winresizer'  " <c-e> and then h/j/k/l and <enter> to resize window easier
" }}}
" {{{ visual-split
" Alternatively, open a new buffer similarly that syncs: https://github.com/chrisbra/NrrwRgn
Plug 'wellle/visual-split.vim'  " Get a perfectly sized split for a section by selecting and doing <leader>s
" vmap <leader>s :'<,'>VSSplitAbove<CR>
vmap v :'<,'>VSSplitAbove<CR>
" }}}
" {{{ vim-lastplace
" Open files at last closed position
Plug 'farmergreg/vim-lastplace'
" }}}

" -----------------------------------------------------------------------------------------
" 4 - Could do without
" -----------------------------------------------------------------------------------------
" {{{ Tabular
" Uses :Tabularize /character(s)
Plug 'godlygeek/tabular'
vmap gt :Tabularize /
" }}}
" {{{ Colorscheme switcher
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
noremap <F9> :RandomColorScheme<CR>:colo<CR>
" }}}
" {{{ matchmaker
" Highlight word under cursor
" Plug 'qstrahl/vim-matchmaker'
" let g:matchmaker_enable_startup = 1
" let g:matchmaker_matchpriority = 1
" }}}
" {{{ Auto-Pairs
" Auto close brackets
" Great until you want to do a macro or enclose existing text
" Plug 'jiangmiao/auto-pairs'
" }}}
" {{{ vim-vinegar
" Nice additions to netrw, but still not fun to rename/move/etc
Plug 'tpope/vim-vinegar'  " Improve file management with NetRW (press -)
" }}}
" {{{ FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
" }}}
" {{{ Targets.vim
" Adds a few text objects, like:
" * aa / ia - an argument
Plug 'wellle/targets.vim'
"}}}
" {{{ Gundo
" Use :Gundo to time travel undo history
Plug 'sjl/gundo.vim'
nmap <leader>u :GundoToggle<CR>
" }}}
" {{{ javascript-libraries-syntax
" Adds some minor extra syntax highlighting for certain libraries
" Seems pretty minor, like I noticed React in React.Component was highlighted
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'lodash,react,flux,d3'
" }}}
" {{{ JSPC
" Argument omnicompletion
" I'm not sure if this one actually works with YouCompleteMe?
Plug 'othree/jspc.vim'
" }}}
" {{{ HardMode
" Plug 'wikitopian/hardmode'  " :call HardMode() to force yourself to not use single motions
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" nnoremap <leader><leader>h <Esc>:call ToggleHardMode()<CR>
" }}}
" {{{ Dirvish
" Plug 'justinmk/vim-dirvish'  " File manager
" noremap - :e %:p:h<CR>
" noremap - :Dirvish %<CR>
" noremap - :Dirvish %:p:h<CR>
" let g:dirvish_relative_paths = 1
" }}}
" {{{ Dracula (colorscheme)
Plug 'dracula/vim'
" }}}
" {{{ Unimpaired
Plug 'tpope/vim-unimpaired'
" }}}
" {{{ Wildfire
" Press Enter to select the closest text object. Press Enter again to expand
" to the next largest text object,
Plug 'gcmt/wildfire.vim'
"}}}
" {{{ Vim Maximizer
" Plug 'szw/vim-maximizer'
" nmap <leader>f :MaximizerToggle<CR>
nmap <leader>f <bar>_
" augroup maximizepane
"   autocmd!
"   autocmd BufEnter *.{js} :norm |<CR>
"   autocmd BufEnter *.{js} :norm _<CR>
" augroup END
" }}}
" {{{ vim-syntax-expand
" Like abbreviations, but _head can detect if first character on line, and
" doesn't require you to press space to expand
" Plug 'Wolfy87/vim-syntax-expand'
" autocmd FileType javascript inoremap <silent> <buffer> @ <C-r>=syntax_expand#expand("@", "this")<CR>
" autocmd FileType javascript inoremap <silent> <buffer> # <C-r>=syntax_expand#expand("#", ".prototype.")<CR>
" autocmd FileType javascript inoremap <silent> <buffer> < <C-r>=syntax_expand#expand_head("<", "return ")<CR>
" autocmd FileType javascript inoremap <silent> <buffer> >> <C-r>=syntax_expand#expand(">>", "=>")<CR>
" }}}
" {{{ vim-json
" Conceal quotes in JSON
Plug 'elzr/vim-json'
" let g:vim_json_syntax_conceal=1
" }}}
" {{{ Peekaboo
Plug 'junegunn/vim-peekaboo'
" }}}

" -----------------------------------------------------------------------------------------
" 5 - New / Evaluating
" -----------------------------------------------------------------------------------------
" {{{ Vim-Pad
" :Pad new
" :Pad ls
" TODO: This is adding hotkeys to <leader>s, causing a timeout
" Plug 'fmoralesc/vim-pad'
" let g:pad#dir = '~/notes/'
" }}}
" {{{ kana/vim-textobj-user
Plug 'kana/vim-textobj-user'
" }}}
" {{{ Abolish
" %S/foo/bar will replace smart-casing
" %S/map{,s}/draw{,ings} will replace variants of the words
" Also change word naming convention
" crk - kabob-case
" crs - snake_case
" crc - camelCase
" crm - MixedCase
Plug 'tpope/tpope-vim-abolish'
" }}}
" {{{ Vim Table Mode
Plug 'dhruvasagar/vim-table-mode'
" }}}
" {{{ Tagbar
Plug 'majutsushi/tagbar'
map _ :Tagbar<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_case_insensitive = 1
" }}}
" {{{ Gutentags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['*node_modules*', '*bower_components*', 'tmp*', 'temp*', 'package*json']
5
" }}}
" {{{ lfv89/vim-interestingwords
Plug 'lfv89/vim-interestingwords'
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
nnoremap <silent> n :nohlsearch<cr>:call WordNavigation('forward')<cr>
nnoremap <silent> N :nohlsearch<cr>:call WordNavigation('backward')<cr>
" }}}
Plug 'jeetsukumaran/vim-buffergator'
call plug#end()

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" }}} ======================================================================

" {{{ Languages

" {{{ Python
let g:pymode_options_max_line_length=120
let g:python_highlight_all=1
augroup pythonsettings
  autocmd!
  autocmd Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
  autocmd Syntax python setlocal foldmethod=indent
  autocmd Syntax python normal zR
augroup END
augroup pythondispatch
  autocmd!
  autocmd FileType python map ,r :Dispatch python %:p<CR>
augroup END
" }}}

" {{{ Javascript
" nmap gd :TernDef<CR>
" nmap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap gf 0f"lv$F/"py:FZF<CR>foo
" nnoremap gf :call TagsUnderCursor()<CR>
" map <leader>rn :!node %:p<CR>
" autocmd FileType javascript,javascript.jsx nmap gd :TernDef<CR>
" autocmd! FileType javascript,javascript.jsx nmap <leader>r :!node %:p<CR>
" autocmd! FileType javascript.jsx map ,r :call VimuxRunCommand("npm start")
" autocmd! FileType javascript.jsx map ,t :call VimuxRunCommand("npm start")
" augroup javascript
"   autocmd!
"   autocmd FileType javascript,javascript.jsx map <buffer> ,r :call VimuxRunCommand("npm start")<CR>
"   autocmd FileType javascript,javascript.jsx map <buffer> ,t :Dispatch npm test<CR>

"   autocmd FileType javascript,javascript.jsx setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
"   autocmd FileType javascript,javascript.jsx setlocal makeprg=/usr/local/bin/eslint
"   autocmd FileType javascript,javascript.jsx command! -buffer Make silent make % | silent redraw! | silent wincmd p | cw
"   autocmd BufWritePost *.js Make
" augroup END
" }}}

" {{{ Other Languages
" autocmd! Syntax c,cpp,xml,html,xhtml setlocal foldmethod=syntax
" autocmd! Syntax c,cpp,xml,html,xhtml,perl normal zR
autocmd! Syntax java map <F1> :!javac %:p && java HelloWorld<CR>
" autocmd! Syntax javascript map <F1> :!node %:p<CR>
autocmd! Syntax ruby map <F1> :!./bin/rails server<CR>

" Vue.js .vue file set filetype on load
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }}}

" }}}

" {{{ File Marks
" Automatically bookmark last files accessed by directory
augroup filemarks
  autocmd!
  autocmd BufEnter *.{js,jsx,coffee} normal! mJ
  autocmd BufEnter */parsers/*       normal! mP
  autocmd BufEnter */epics/*         normal! mE
  autocmd BufEnter */routes/*        normal! mR
  autocmd BufEnter */reducers/*      normal! mS
  autocmd BufEnter */components/*    normal! mC
  autocmd BufEnter */utils/*         normal! mU
  autocmd BufEnter */api/*           normal! mA
  autocmd BufEnter */api/*           normal! mA

  autocmd BufWinLeave */src/* normal! mQ
  autocmd InsertEnter */src/* normal! mI
  autocmd TextChanged	*/src/* normal! mO
  autocmd TextChangedI */src/* normal! mO
augroup END
" }}}

" {{{ Mappings

" {{{ Comma

" map ,, :b<Space>
" map ,f :find<Space>
" map ,e :find epics/**/**<LEFT>
" map ,p :find parsers/**/**<LEFT>
" map ,c :find components/**/**<LEFT>
" map ,re :find reducers/**/**<LEFT>
" map ,ro :find routes/**/**<LEFT>
" map ,, :CtrlPLine<CR>
" map ,, :BLines<CR>
" map ,f :CtrlPMRUFiles<CR>
" map ,e :CtrlPMRUFiles epics/<CR>
" map ,p :CtrlPMRUFiles parsers/<CR>
" map ,c :CtrlPMRUFiles components/<CR>
" map ,re :CtrlPMRUFiles reducers/<CR>
" map ,ro :CtrlPMRUFiles routes/<CR>
" map <c-p> :History<CR>
" map ,, :Marks<CR>
" map ,f :FZF<CR>
" map ,e :FZF epics/<CR>
" map ,p :FZF parsers/<CR>
" map ,c :FZF components/<CR>
" map ,re :FZF reducers/<CR>
" map ,ro :FZF routes/<CR>

" }}}

" {{{ Function Keys
map <F1> :map <F1> :!
map <F2> "hyiw:%s/<c-r>h//c<LEFT><LEFT>
" map <F4> "hyiw:Ag <c-r>h
map <F5> :NERDTreeToggle<CR>
noremap <F6> :!tig %<CR>
nmap <F7> "hyiw:!open 'https://www.google.com/search?newwindow=1&site=&source=hp&q=<c-r>h'
vmap <F7> "hy:!open 'https://www.google.com/search?newwindow=1&site=&source=hp&q=<c-r>h'
map <F12> "hyiw:Dash <c-r>h<CR>
vmap <F12> "hy:Dash <c-r>h<CR>
" }}}

" {{{ Leader <Space>

nmap <leader><leader>i :PlugInstall<CR>
nmap <leader><leader>j :join<CR>
nmap <leader><leader>u :PlugClean!<CR>
nmap <leader><leader>v :sp ~/dotfiles/.vimrc<CR>
nmap <leader><leader>t :sp ~/dotfiles/.ctags<CR>

map <leader>c :bd<CR>
nmap <leader>oh !open https://github.com/search?q=
nmap <leader>on "pyi":!open https://www.npmjs.com/package/p
nmap <leader>oo !open https://www.google.com/search?q=javascript+
nmap <leader>q :q<CR>
nmap <leader>s :sp<CR>
nmap <leader>v :vsp<CR>
nmap <leader>w :w<CR>

" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c

" Switch to previous file
map <leader><tab> <c-^>

nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>
nmap <leader>7 :set foldlevel=7<CR>
nmap <leader>9 :set foldlevel=999<CR>

" }}}

" {{{ Visual Mode
vmap I :norm I
vmap A :norm A
vmap \ :norm<space>^
vmap <bar> :g/
vmap <leader>s :sort<CR>
nmap <leader>l yiw{oconsole.error(""", ")^
vmap <leader>l y{oconsole.error(""", ")^


vmap r :S/
vmap M :join<CR>
" }}}

" {{{ Window Keys
" Maximize window
map  _|
map f _<bar>
" }}}

" {{{ Default behavior overrides

nnoremap g} :split<CR>gd

" Always search regular regex - no escape characters needed
nnoremap / /\v
vnoremap / /\v

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Center screen when going through search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

" Match indent level on paste
" TODO: this can mess up batch :norm mode pasting
nnoremap P ]P
nnoremap p ]p

" Y should copy to end of line, not full line, same as D
noremap Y y$

" }}}

" {{{ Changelist
" Use c-f and c-b to move through quickfix, e.g. when using Grepper
" noremap <c-f> :cnext<CR>
" noremap <c-b> :cprev<CR>

map ! :!
" }}}


" {{{ Navigation in buffer
map J }zz
map K {zz
map H [{
map L ]}
" vmap J }zz
" vmap K {zz
" nmap J :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>zz
" nmap K :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>zz
" nmap H zk
" nmap L zj
" nmap ; /class\\|const \[A-Z\]\\|default<CR>zt
" }}}

" {{{ Navigate panes
" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l
" }}}


imap <c-z> <c-y>,

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" }}}

" {{{ Functions
function! StripTrailingWhitespace ()
  " Don't strip on these filetypes
  if &ft =~ 'sql'
    return
  endif
  %s/\s\+$//e
endfunction
augroup stripwhitespace
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespace()
augroup END

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" " Keep location of file when reopening
" augroup keeplocation
"   autocmd!
"   autocmd BufReadPost *
"   \   if line("'\"") > 0 && line("'\"") <= line("$") |
"   \       exe 'normal! g`"zvzz' |
"   \   endif
" augroup END

" Prevent browsing in Fugitive from creating a trail of temp file buffers
augroup fugitive
  autocmd! BufReadPost fugitive://*
  autocmd BufReadPost fugitive://*
    \ set bufhidden=delete
augroup END

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

" vmap \em :call ExtractMethod()<CR>
" function! ExtractMethod() range
"   let name = inputdialog("Name of new method: ")
"   '<
"   exe "normal! O\<BS>" . name ."()\<CR>{\<Esc>"
"   '>
"   exe "normal! oreturn ;\<CR>}\<Esc>k"
"   s/return/\/\/ return/ge
"   normal! j%
"   normal! kf(
"   exe "normal! yyPi// = \<Esc>wdwA;\<Esc>"
"   normal! ==
"   normal! j0w
" endfunction


" }}}

" {{{ Formatting
" autocmd FileType javascript set formatprg=prettier\ --stdin\ --trailing-comma\ all\ --no-bracket-spacing
" autocmd BufWritePre *.js :normal mFggVGgq'
" nmap <silent> = ggVGgq
" xnoremap <silent> = gq
" }}}


" {{{ Abbreviations
abbreviate --- -----------------------------------------------------------------------------------------
" }}}

" {{{ Colorscheme
set termguicolors
set background=dark

" colorscheme beekai
" colorscheme badwolf
" colorscheme molokai
" colorscheme Monokai
" colorscheme void
" colorscheme sift
" colorscheme darkburn
syntax on
" colorscheme null
" colorscheme predawn
" colorscheme zenburn
" colorscheme elflord
" colorscheme gruvbox
" colorscheme dracula
" colorscheme solarized
" colorscheme monokai
" colorscheme deus
colorscheme flattr
" }}} Colorscheme

" {{{ Highlights
" These come after Colorscheme so they don't get overwritten
"
" {{{ Background
highlight Normal guibg=#2a2a2a
" }}}
"
" {{{ Comments
highlight Comment guifg=#999999
" }}}
"
" {{{ Current line
set nocursorline
highlight cursorLine term=bold cterm=bold guibg=#444444
" }}}
" {{{ Column 80
set colorcolumn=
highlight ColorColumn ctermbg=240 guibg=#3a3a3a
" }}}

" {{{ vim_current_word
" highlight CurrentWord term=reverse ctermfg=235 ctermbg=214 guifg=#282828 guibg=#fabd2f
" highlight CurrentWordTwins guibg=#587474 gui=underline  ctermbg=2 cterm=underline
" }}}
" {{{ gitgutter
highlight GitGutterAdd          guibg=#505050
highlight GitGutterChange       guibg=#505050
highlight GitGutterDelete       guibg=#505050
" }}}
" {{{ matchmaker
hi default Matchmaker term=underline    ctermbg=238     guibg=#555555
" }}}
" {{{ Numbers
hi LineNr guifg=#4a4a4a
" }}}
" }}}

" {{{ Macros / macro-like mappings

" Convert React stateless functional class to a full stateful class
" map \c j?constcwclasswea extends React.component ldt{oconstructor(props) {super(props);this.state = {};}render() {]}O}v%:s/props/this.props=
" map \f j?classcwconstelct{ = (props) => /constructor$V%d/render$%dddd[{v%:s/this.props/props
" map \m yiw20HopA() {}k
"OpA() {}
" }}}

" {{{ Conceal
set conceallevel=0
set concealcursor=
" }}}

" {{{ Folding
" function! NeatFoldText()
"   let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
"   let lines_count = v:foldend - v:foldstart + 1
"   let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
"   let foldchar = matchstr(&fillchars, 'fold:\zs.')
"   let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
"   let foldtextend = lines_count_text . repeat(foldchar, 8)
"   let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
"   return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
" endfunction
" set foldtext=NeatFoldText()
" }}}

" {{{ Text Objects
call textobj#user#plugin('htmlattribute', {
\   'attribute': {
\     'select-a-function': 'CurrentAttributeA',
\     'select-a': ['ah'],
\     'region-type': 'v',
\     'scan': 'cursor',
\   }
\ })
function! CurrentAttributeA()
  normal! elBh
  let head_pos = getpos('.')
  normal! f{%
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction
call textobj#user#plugin('delimited', {
\   'attribute': {
\     'select-a-function': 'CurrentDelimitedA',
\     'select-a': ['ad'],
\     'region-type': 'v',
\     'scan': 'cursor',
\   }
\ })
function! CurrentDelimitedA()
  normal! ?[{,]l
  let head_pos = getpos('.')
  normal! /[},]h
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction
" }}}

" {{{ .vimrc
" autocmd! bufwritepost .vimrc source % | AirlineRefresh | setlocal foldmethod=marker
" augroup vimrc
"   autocmd!
"   " autocmd bufwritepost .vimrc source % | setlocal foldmethod=marker
"   autocmd bufwritepost .vimrc source %
"   autocmd BufRead,BufNewFile .vimrc setlocal foldmethod=marker
" augroup END
" }}}
