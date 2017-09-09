" {{{ Options

" Don't use a swapfile
set noswapfile

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
" set winheight=7
" set winwidth=7
" set winminwidth=7
" set winminheight=7

" If you open up gVim for whatever reason
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" allow cursor to stay in same column while scrolling
set virtualedit=all

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
" set scrolloff=17

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
set showmatch

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


set magic
set browsedir=buffer
set nobackup
set nowritebackup
set number
set numberwidth=7
set relativenumber

set complete=.,w,b,u,t
set completeopt=menuone,preview
set wildcharm=<TAB>

set wildmenu
" set wildmode=full
set wildmode=list:full
set wildchar=<Tab>

" Always show the statusline
set laststatus=2
set statusline=%f
set statusline+=%=        " Switch to the right side
set statusline+=%#warningmsg#

set incsearch
set nohlsearch
set noignorecase              " affects both searching and find/replace
set smartcase

set foldmethod=indent
set foldnestmax=8
set foldlevelstart=2
set foldmethod=indent



let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

set showtabline=0

" Change CWD while navigating in NetRW.
" This is necessary if you want to move a file like this: mt > cd > mf > mm
" Otherwise you have to manually change cwd as well: mt > cd > c > mf > mm
" let g:netrw_keepdir=0
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'

" Auto indent wasn't working without this on bottom
filetype indent on
set ai
set si


let g:used_javascript_libs = 'jquery, underscore, backbone, angularjs'

" Allow the :find command to search current directory recursively for a file
" E.g. :find myfile.text
" https://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim
set path+=**

" Allow gf to find JavaScript file references without extension
set suffixesadd=.js,.jsx

" Set window title to include current filename.
" Great for use in iterm2: press cmd+shift+o and search for filename of a
" window
set t_ts=]1;
set t_fs=
set title

" Fix Vim background in Tmux, don't break colors at end of line.
set t_ut=
set t_Co=256

let mapleader = "\<Space>"

" How long leader key and other key combinations will wait for another key
" NOTE: Usually the timeout shouldn't be needed for <leader> / <space> in
" insert mode. If you start having this timeout apply, something must have set
" up imap <space> or something similar. Use this to debug:
" :verbose imap <space>
set timeoutlen=1000
set ttimeoutlen=0

" }}}

" {{{ Plugins
call plug#begin('~/.vim/bundle')
" 1 - Essential
" {{{ Ctrl P
Plug 'ctrlpvim/ctrlp.vim'
nnoremap <silent> <c-t> :CtrlPLine<CR>
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
" {{{ gitgutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
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

" 2 - Great
" {{{ Surround
" Plug 'tpope/vim-surround'
" }}}
" {{{ Workspace
Plug 'thaerkh/vim-workspace'
nmap <leader><leader>w :ToggleWorkspace<CR>
" }}}
" {{{ CtrlSF
Plug 'dyng/ctrlsf.vim'
map <F3> :CtrlSF ""<LEFT>
nmap <leader><leader>8 "hyiw:CtrlSF <c-r>h<CR>
nmap <leader>/ :CtrlSF ""<LEFT>
nmap <leader><leader>/ :CtrlSF "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" }}}
" {{{ vim-simple-todo
Plug 'vitalk/vim-simple-todo'  " Shortcuts to creating todo lists
let g:simple_todo_map_keys = 0
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
" {{{ Trailer Trash - Remove trailing spaces
Plug 'csexton/trailertrash.vim'
augroup removetrailingspaces
  autocmd!
  autocmd BufWritePre * TrailerTrim
augroup END
" }}}
" {{{ GoldenView
" Auto resize windows when switching windows
Plug 'zhaocai/GoldenView.Vim'
let g:goldenview__enable_default_mapping = 0
" nmap <silent> <C-S>  <Plug>GoldenViewSplit
" nmap <silent> <leader>m   <Plug>GoldenViewSwitchMain
" nmap <silent> <leader><leader>m <Plug>GoldenViewSwitchToggle
" nmap <silent> <C-N>  <Plug>GoldenViewNext
" nmap <silent> <C-P>  <Plug>GoldenViewPrevious
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

" 3 - Decent
" {{{ Airline / Lightline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
" let g:airline_theme='minimalist'
let g:airline_theme='deus'
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
Plug 'tpope/vim-sleuth'  " Auto set file tab settings based on current file or other files in directory
Plug 'tmhedberg/matchit' " Use % to match HTML tags
Plug 'flazz/vim-colorschemes'
" {{{ vim-javascript
" This sometimes has issues unfortunately with JSX
Plug 'pangloss/vim-javascript'

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
" {{{ incsearch
" Extended search and fuzzy search
" Fuzzy search allows you to exclude spaces and such
" While searching, <c-j> can go to next PAGE of matches before pressing enter
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" map /  <Plug>(incsearch-fuzzy-/)
" map ? <Plug>(incsearch-fuzzy-?)
map z/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" }}}
" {{{ EasyMotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
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
Plug 'wellle/targets.vim'
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

" 4 - Could do without
" {{{ Colorscheme switcher
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
noremap <F9> :RandomColorScheme<CR>:colo<CR>
" }}}
" {{{ matchmaker
" Highlight word under cursor
Plug 'qstrahl/vim-matchmaker'
let g:matchmaker_enable_startup = 1
let g:matchmaker_matchpriority = 1
" }}}
" Plug 'jiangmiao/auto-pairs'
" Nice additions to netrw, but still not fun to rename/move/etc
" Plug 'tpope/vim-vinegar'  " Improve file management with NetRW (press -)
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

" 5 - New / Evaluating
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'lodash,react,flux,d3'

Plug 'othree/jspc.vim'
" {{{ ALE
Plug 'w0rp/ale'  " Async linting
let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
let g:ale_javascript_eslint_use_global = 1
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \}
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
noremap _ :NERDTreeClose<CR>
" noremap - :call ToggleNERDTreeFind()<CR>
noremap - :topleft NERDTreeFind<CR>
" noremap - :topleft NERDTree<CR>
" noremap _ :NERDTree<CR>
map <leader>b :Bookmark<space>
" }}}
Plug 'tpope/vim-rhubarb'  " Adds :Gbrowse to Fugitive for jumping to the Github repo
Plug 'chrisbra/NrrwRgn'  " :NR on selected text to open focused split that syncs
Plug 'simeji/winresizer'  " <c-e> and then h/j/k/l and <enter> to resize window easier
Plug 'sheerun/vim-polyglot'  " Collection of language plugins
" Plug 'mxw/vim-jsx'  " Vim JSX
Plug 'ton/vim-bufsurf'  " Previous buffer history with :BufSurfForward and :BufSurfBackward
" Plug 'sickill/vim-pasta'  " Adjust pasted text indentation to match surrounding block, works automatically overriding <p>
" {{{ HardMode
Plug 'wikitopian/hardmode'  " :call HardMode() to force yourself to not use single motions
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader><leader>h <Esc>:call ToggleHardMode()<CR>
" }}}
" {{{ visual-split
Plug 'wellle/visual-split.vim'  " Get a perfectly sized split for a section by selecting and doing <leader>s
vmap <leader>s :'<,'>VSSplitAbove<CR>
" }}}
" {{{ yankstack
" Plug 'maxbrunsfeld/vim-yankstack'  " Clipboard history by repeating <leader>p, was still remapping s key when I told it not to
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" }}}
" {{{ Dirvish
" Plug 'justinmk/vim-dirvish'  " File manager
" noremap - :e %:p:h<CR>
" noremap - :Dirvish %<CR>
" noremap - :Dirvish %:p:h<CR>
" let g:dirvish_relative_paths = 1
" }}}
Plug 'int3/vim-extradite'
Plug 'farmergreg/vim-lastplace'
" {{{ Tabular
" Uses :Tabularize /character(s)
Plug 'godlygeek/tabular'
vmap gt :Tabularize /
" }}}
Plug 'dracula/vim'
Plug 'tpope/vim-unimpaired'
" {{{ Interesting Words
Plug 'lfv89/vim-interestingwords'
"}}}
" {{{ Targets.vim
" Press Enter to select the closest text object. Press Enter again to expand
" to the next largest text object,
Plug 'gcmt/wildfire.vim'
"}}}
" {{{ Qlist
" Show [I (buffer matches for word under cursor) in a Quickfix window :copen
Plug 'romainl/vim-qlist'
nmap <leader>8 :Ilist <CR>
nmap <leader>* :Ilist <CR>
" }}}
" {{{ Ranger.vim Ranger integration
" Plug 'francoiscabrol/ranger.vim'
" map - :Ranger<CR>
" map - :e %:p:h<CR>
" }}}
" {{{ CloseTag
" TODO: evaluate removing / workaround. It causes leader key to have a
" timeout. See:
" :verbose imap <Space>
" Plug 'alvan/vim-closetag'
" let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.xml'
" }}}
Plug 'altercation/vim-colors-solarized'

" {{{ Vim Maximizer
Plug 'szw/vim-maximizer'
nmap <leader>f :MaximizerToggle<CR>
" }}}
" {{{ Vim-Pad
" :Pad new
" :Pad ls
Plug 'fmoralesc/vim-pad'
let g:pad#dir = '~/notes/'
" }}}
" {{{ Peekaboo
Plug 'junegunn/vim-peekaboo'
" }}}
" {{{ vim-json
" Conceal quotes in JSON
Plug 'elzr/vim-json'
" let g:vim_json_syntax_conceal=1
" }}}
" {{{ vim-syntax-expand
" Like abbreviations, but _head can detect if first character on line, and
" doesn't require you to press space to expand
Plug 'Wolfy87/vim-syntax-expand'
autocmd FileType javascript inoremap <silent> <buffer> @ <C-r>=syntax_expand#expand("@", "this")<CR>
autocmd FileType javascript inoremap <silent> <buffer> # <C-r>=syntax_expand#expand("#", ".prototype.")<CR>
autocmd FileType javascript inoremap <silent> <buffer> < <C-r>=syntax_expand#expand_head("<", "return ")<CR>
autocmd FileType javascript inoremap <silent> <buffer> >> <C-r>=syntax_expand#expand(">>", "=>")<CR>

" }}}
call plug#end()

" }}}

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

if !exists('*TagsUnderCursor')
  function TagsUnderCursor()
    try
      let default_input_save = get(g:, 'ctrlp_default_input', '')
      let g:ctrlp_default_input = expand('<cfile>')
      CtrlP
    finally
      if exists('default_input_save')
        let g:ctrlp_default_input = default_input_save
      endif
    endtry
  endfun
endif

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
"   autocmd FileType javascript,javascript.jsx map ,r :call VimuxRunCommand("npm start")<CR>
"   autocmd FileType javascript,javascript.jsx map ,t :Dispatch npm test<CR>
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

" map <leader>/ "hyiw:Ag
nmap <leader><leader>i :PlugInstall<CR>
nmap <leader><leader>j :join<CR>
nmap <leader><leader>u :PlugClean!<CR>
nmap <leader><leader>v :sp ~/dotfiles/.vimrc<CR>

map <leader>c :bd<CR>
" map <leader>l :set list!<CR>
" map <leader>o :copen<CR>
" map <leader>p :set paste!<CR>
" nmap <leader>8 "hyiw:Ag <c-r>h<CR>:nohlsearch<CR>
nmap <leader>oh !open https://github.com/search?q=
nmap <leader>on "pyi":!open https://www.npmjs.com/package/p
nmap <leader>oo !open https://www.google.com/search?q=javascript+
nmap <leader>q :q<CR>
nmap <leader>s :sp<CR>
nmap <leader>t :NERDTreeFind<CR>
nmap <leader>v :vsp<CR>
nmap <leader>w :w<CR>

" Diff put to grab changes using comma
" noremap , :diffput<CR>

" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c
nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>
nmap <leader>7 :set foldlevel=7<CR>
" nmap <leader>8 :set foldlevel=8<CR>
nmap <leader>9 :set foldlevel=999<CR>

" }}}

" {{{ Visual Mode
vmap I :norm I
vmap A :norm A
vmap \ :norm<space>
vmap s :sort<CR>
vmap r :s/
" vmap S :s/  " Interferes with Surround...
vmap M :join<CR>
" }}}

" {{{ Window Keys
map  _|
map f _<bar>
" }}}

map ,1 1
map ,2 2
map ,3 3
map ,4 4
map ,5 5
map ,6 6
map ,7 7
map ,8 8
map ,9 9

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

map <leader><tab> <c-^>

noremap <c-f> :cnext<CR>
noremap <c-b> :cprev<CR>

" map gs :topleft 12split ~/.scratch<CR>
map gs :topleft split ~/.scratch<CR>

" Center screen when going through search results
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz

map Q :cprev<CR>
map <c-q> :cnext<CR>

let g:ag_highlight=1

" Don't automatically do line breaks on long lines
" set formatoptions-=t

" Don't skip wrapped lines
" nnoremap j gj
" nnoremap k gk

map J }
map K {
map H [{
map L ]}
" map <leader>h [{
" map <leader>l ]}
map <silent> <leader>h :BufSurfBack<CR>
map <silent> <leader>l :BufSurfForward<CR>

vmap <leader><leader>n :norm
nmap <leader><leader>g :%g/

nmap s <Plug>(easymotion-bd-w)

" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l

map ! :!

imap <c-z> <c-y>,

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" repeat.vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Emmet expand html
imap <c-e> <c-y>,

nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

nmap gR :YcmCompleter GoToReferences<CR>
" let g:airline_section_a = '%{substitute(expand("%:p:h"), getcwd(), "", "")}'

map ; 

" }}}

" {{{ Functions

if !exists('*RangerExplorer')
  function RangerExplorer()
      exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
      if filereadable('/tmp/vim_ranger_current_file')
          exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
          call system('rm /tmp/vim_ranger_current_file')
      endif
      redraw!
  endfun
endif
" map - :call RangerExplorer()<CR>

" function! VimFilerExplorer()
"   if expand("%:t") == "vimfiler:default"
"     execute <Plug>(vimfiler_switch_to_parent_directory)
"   else
"     call vimfiler#custom#profile('default', 'context', {
"           \ 'safe' : 0,
"           \ 'edit_action' : 'tabopen',
"           \ })
"     VimFilerBufferDir -find -buffer-name=explorer -force-quit
"     echom expand("%")
"     " echom "Bar"
"   endif
" endfun
" map - :call VimFilerExplorer()<CR>

function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

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

" }}}

" {{{ Abbreviations
" abbreviate --- -----------------------------------------------------------------------------------------
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
colorscheme deus
" }}} Colorscheme

" {{{ Highlights
" These come after Colorscheme so they don't get overwritten
"
" {{{ Highlight current line
set cursorline
highlight cursorLine term=bold cterm=bold guibg=#444444
" }}}
" {{{ Highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=240 guibg=#3a3a3a
" }}}

" {{{ vim_current_word
highlight CurrentWord term=reverse ctermfg=235 ctermbg=214 guifg=#282828 guibg=#fabd2f
highlight CurrentWordTwins guibg=#587474 gui=underline  ctermbg=2 cterm=underline
" }}}
" {{{ gitgutter
highlight GitGutterAdd          guibg=#368430
highlight GitGutterChange       guibg=#305aa2
highlight GitGutterDelete       guibg=#502020
" hi GitGutterAddLine          guibg=#368430
" hi GitGutterChangeLine       guibg=#305aa2
" hi GitGutterDeleteLine       guibg=#502020
" hi GitGutterChangeDeleteLine " default: links to GitGutterChangeLineDefault
" }}}
" {{{ matchmaker
hi default Matchmaker term=underline    ctermbg=238     guibg=#555555
" }}}
" }}}

" {{{ Macros / macro-like mappings

" Convert React stateless functional class to a full stateful class
map \c j?constcwclasswea extends React.component ldt{oconstructor(props) {super(props);this.state = {};}render() {]}O}v%:s/props/this.props=
map \f j?classcwconstelct{ = (props) => /constructor$V%d/render$%dddd[{v%:s/this.props/props
" }}}

" {{{ Conceal
set conceallevel=1
set concealcursor=cnv
" }}}

" {{{ .vimrc
" autocmd! bufwritepost .vimrc source % | AirlineRefresh | setlocal foldmethod=marker
augroup vimrc
  autocmd!
  " autocmd bufwritepost .vimrc source % | setlocal foldmethod=marker
  autocmd bufwritepost .vimrc source % | setlocal foldmethod=marker
  autocmd BufRead,BufNewFile .vimrc setlocal foldmethod=marker
augroup END
" }}}
