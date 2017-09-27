" { Options

" Don't use swap or backup files
set noswapfile
set nobackup
set nowritebackup

" No undodir, don't undo past last close
set noundofile

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

" Show tabs, trailing characters as periods
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Don't fully collapse windows when doing <c-w>_ or <c-w>|
set winheight=1
set winwidth=33
set winminwidth=33
set winminheight=1

" If you open up gVim for whatever reason
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" allow cursor to stay in same column while scrolling
set virtualedit=all
set nostartofline

" allow copy/paste using system clipboard (otherwise have to use "+)
set clipboard=unnamed

" The basics
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent

" Allow backspace to go past beginning of line
set backspace=indent,eol,start

" Keep cursor centered -- this is choppy if scrolling multiple splits
set scrolloff=10

" Use Bash shell syntax for :! (even if you are in Fish or ZSH)
set shell=bash

" Use MORE as pager
set more

" Don't redraw screen when using a macro or register
set lazyredraw

" Improve smoothness of redrawing
set ttyfast

" Send the current mouse codes over when clicking
" set ttymouse=xterm2

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
set timeoutlen=800
set ttimeoutlen=0

" Minimize how often you see "Press enter or type a command to continue"
set shortmess=a
set cmdheight=2

" }

" { Neovim specific options

" Show interactive preview of substitute changes when using :%s///
set inccommand=split
" }

" { Vim-Plug
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }

" { Plugins
call plug#begin('~/.vim/bundle')
" -----------------------------------------------------------------------------------------
" 1 - Essential
" -----------------------------------------------------------------------------------------
" { Dirvish
Plug 'justinmk/vim-dirvish'  " File manager
noremap - :Dirvish %<CR>
noremap - :Dirvish %:p:h<CR>
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:dirvish_relative_paths=1
function! Relpath(filename)
	let cwd = getcwd()
	let s = substitute(a:filename, l:cwd . "/" , "", "")
	return s
endfunction
function! InsertBookmarks()
  " execute "norm gg:read ~/dotfiles/nvim/bookmarks"
  execute "norm mZ"

  execute "norm ggI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  execute "norm I" . substitute(Relpath(expand("%:p")), '/', ' > ', 'g') . ""
  " execute "norm I> " . substitute(substitute(fnamemodify(expand("%"), ":~:."), '/', '', ''), '/', ' > ', 'g') . ""
  execute "norm I~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

  " execute "norm G:read ~/dotfiles/nvim/bookmarks\<cr>"
  call feedkeys("")

  " execute "norm 2\<c-o>0"
  execute "norm 1\<c-o>0"
endfunction
augroup dirvish
  autocmd!
  " autocmd FileType dirvish nnoremap <buffer> <leader>r :Renamer %<CR>
  autocmd FileType dirvish nnoremap <buffer> <leader>r :Shdo! mv {} {}<CR>
  autocmd FileType dirvish nnoremap <buffer> <leader>c :Shdo! cp -R {} {}:h<CR>
  autocmd FileType dirvish nnoremap <buffer> <leader>d :Shdo! rm -rf {} {}:h<CR>
  autocmd FileType dirvish nnoremap <buffer> e :e %
  autocmd FileType dirvish nnoremap <buffer> cp :call feedkeys(':!cp ' . expand('<cWORD>') . ' %')<CR>
  " autocmd FileType dirvish nnoremap <buffer> M :Mkdir %
  " autocmd FileType dirvish nnoremap <buffer> D :call feedkeys(':!rm -rf %/' . expand('<cWORD>'))<CR>
  autocmd FileType dirvish nnoremap <buffer> mv :call feedkeys(':!mv ' . expand('<cWORD>') . ' ' . expand('<cWORD>'))<CR>
  autocmd FileType dirvish nnoremap <buffer> dd :call feedkeys(':!rm -rf ' . expand('<cWORD>'))<CR>
  autocmd FileType dirvish nnoremap <buffer> ! :Shdo! {}<LEFT><LEFT><LEFT><SPACE>
  autocmd FileType dirvish nnoremap <buffer> b :norm gg<CR>:0read ~/dotfiles/nvim/bookmarks<CR>

  " Enable :Gstatus and friends.
  autocmd FileType dirvish call fugitive#detect(@%)
  autocmd FileType dirvish call InsertBookmarks()
augroup END
" }
" { CtrlP
" Plug 'ctrlpvim/ctrlp.vim'
" " nnoremap <silent> <c-f> :CtrlPLine<CR>
"
" :nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
" if executable('ag')
"   set grepprg=ag\ --nogroup\ --nocolor
"   let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-ignore ~/.agignore -g ""'
"   let g:ctrlp_use_caching = 0
" elseif executable('rg')
"   set grepprg=rg
"   let g:ctrlp_user_command = 'rg %s --files --color=never --ignore-file ~/.agignore --glob ""'
"   let g:ctrlp_use_caching = 0
" elseif executable('ack')
"   set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
" endif
" let g:ctrlp_cmd = 'CtrlPBuffer'
" let g:ctrlp_use_caching = 0
" let g:ctrlp_by_filename = 0
" let g:ctrlp_regexp = 0
" let g:ctrlp_match_window_reversed = 0
" let g:ctrlp_mruf_relative = 1
" let g:ctrlp_match_current_file = 0
" let g:ctrlp_match_window = 'bottom,order:btt'
" let g:ctrlp_switch_buffer = 'e'
" let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_default_input = 0
" let g:ctrlp_types = ['buf', 'mru', 'fil']
" let g:ctrlp_mruf_exclude = '.*/temp/.*' " MacOSX/Linux
" let g:ctrlp_mruf_relative = 1
" let g:ctrlp_extensions = []
" }
" { Fugitive / Extradite
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'  " Adds :Gbrowse to Fugitive for jumping to the Github repo
Plug 'int3/vim-extradite'
Plug 'jreybert/vimagit'
map <leader>gg :Magit<CR>
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
" }
" { GitGutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0
noremap ]c :GitGutterNextHunk<CR>
noremap [c :GitGutterPrevHunk<CR>
" }
" { Vimux / Dispatch
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'  "  Run external commands in a small split Tmux pane
let g:VimuxHeight = "20"
let g:VimuxPromptString = "Vimux>  $ "
map ,v :call VimuxPromptCommand("npm start")<CR>
" Dispatch is better for single tasks, shows quickfix results afterwards
map ,d :Dispatch<SPACE>
function! VimuxRunFromClipboard()
  let clipboardText = @+
  let clipboardText = substitute(clipboardText, "\n", "", "g")
  let clipboardText = substitute(clipboardText, "\r", "", "g")
  let clipboardText = substitute(clipboardText, "^@", "", "g")

  let clipboardText = substitute(clipboardText, "http://", "", "")
  let command = ':!' . clipboardText
  execute command
endfunction
vmap ,r y:call VimuxRunFromClipboard()<CR>
map ,i :call VimuxInspectRunner()<CR>
map ,c :call VimuxInterruptRunner()<CR>
map ,f :Dispatch npm test -- --tests %
map ,b :Dispatch npm run build<CR>
map ,z :VimuxZoomRunner<CR>
" }
" { vim-tmux-navigator
" Ctrl + J/K/H/L to move to different Vim or Tmux panes.
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 2
" }
" { UltiSnips
Plug 'SirVer/ultisnips'
nmap <leader>eu :UltiSnipsEdit<CR>
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir = $HOME."/dotfiles/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/dotfiles/UltiSnips']
let g:UltiSnipsEnableSnipMate = 0
" }
" { Supertab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = '<C-n>'
" }
" { Deoplete
" Unlike YouCompleteMe, Deoplete allowed completion in buffer of a variable
" followed by a property in a string. "rodDimensions." showed all props of
" random variable.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'othree/jspc.vim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 0
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#buffer#require_same_filetype = 0
let g:deoplete#file#enable_buffer_path = 0
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'jspc#omni'
\]
" TODO TernJS slows down Deoplete considerably
" let g:deoplete#omni#functions.javascript = [
"   \ 'tern#Complete',
"   \ 'jspc#omni'
" \]
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g tern' }
" let g:deoplete#sources#ternjs#types = 1
" let g:deoplete#sources#ternjs#depths = 1
" let g:deoplete#sources#ternjs#docs = 1
" let g:deoplete#sources#ternjs#case_insensitive = 1
" let g:deoplete#sources#ternjs#include_keywords = 1
" let g:deoplete#sources#ternjs#in_literal = 1
" let g:deoplete#sources#ternjs#docs = 1
" let g:deoplete#sources#ternjs#filetypes = [
"       \ 'jsx',
"       \ 'javascript.jsx',
"       \ 'vue',
"       \ ]
" let g:tern#filetypes = [ 'jsx', 'javascript.jsx', 'vue' ]
" }
" { vim-polyglot
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
" }
" { vim-obsession
" Save buffers in session using automation over the built-in session
" management. Add vim -S Session.vim alias in your fish.config or .bashrc.
" :qa to exit Vim with all panes intact.
Plug 'tpope/vim-obsession'
nmap <leader><leader>w :Obsess!<CR>
" }
" { Abolish
" %S/foo/bar will replace smart-casing
" %S/map{,s}/draw{,ings} will replace variants of the words
" Also change word naming convention
" crk - kabob-case
" crs - snake_case
" crc - camelCase
" crm - MixedCase
Plug 'tpope/tpope-vim-abolish'
nmap <leader>s yiwV:s/"/"
vmap <leader>s :s/
nmap <leader>S V:S/
vmap <leader>S :S/
nmap <leader><leader>s :%s//
vmap <leader><leader>s y:%s/+/+
nmap <leader><leader>S :%S//
vmap <leader><leader>S y:%S/+/+
" }
" { vim-rest-console
Plug 'diepm/vim-rest-console'
let g:vrc_set_default_mapping = 0
augroup vrc
  autocmd!
  autocmd FileType rest map <buffer> <c-s> :call VrcQuery()<CR>
  autocmd BufLeave   *.rest silent w
augroup END
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_header_content_type = 'application/json; charset=utf-8'
let g:vrc_auto_format_response_enabled = 1
let g:vrc_auto_format_response_patterns = { 'json': 'jq .', 'xml': 'xmllint --format -' }
" VRC sometimes has issues formatting response without --silent
let g:vrc_curl_opts={ '--silent': '' }
" }

" -----------------------------------------------------------------------------------------
" 2 - Great
" -----------------------------------------------------------------------------------------
" { Surround
Plug 'tpope/vim-surround'
vmap s <Plug>VSurround
vmap s <Plug>VSurround
" }
" { Grepper
" Like :grep but a smoother experience. No display of text or flickering.
" Use Ag to search using :GrepperAg, and :copen when finished
" CtrlSF is an alternative, but that doesn't allow :cnext or immediate search
Plug 'mhinz/vim-grepper'
nmap <leader>8 "hyiw:GrepperAg -Q <c-r>h<CR>:nohlsearch<CR>
vmap <leader>8 "hy:GrepperAg -Q '<c-r>h'<CR>
nmap <leader>/ :Grepper<CR>
nmap <leader><leader>/ :GrepperAg "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader><leader><leader>/ :GrepperAg "" %:p:h:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <silent> ,/ :nohlsearch<CR>
" let g:grepper.tools = ['ag', 'ack', 'grep', 'findstr', 'rg', 'pt', 'sift', 'git', ]
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
map ]gb :call ToggleGrepperBuffersMode()<CR>
function! ToggleGrepperDirectoryMode()
  if g:grepper.dir == 'file'
    let g:grepper.dir = 'cwd'
    echo "Grepper will search all files"
  else
    let g:grepper.dir = 'file'
    echo "Grepper will search only current directory"
  endif
endfunction
map ]gd :call ToggleGrepperDirectoryMode()<CR>
nmap gr "hyiw:GrepperAg <c-r>h<CR>
" nmap gi :GrepperAg '%{expand("%:p:t:r")}'<CR>
" nmap gi :GrepperAg %:p:t:r<CR>
" map <F4> "hyiw:GrepperAg <c-r>h<CR>
let g:grepper = {}
runtime autoload/grepper.vim
let g:grepper.jump = 0
let g:grepper.stop = 500
let g:grepper.highlight = 1
" This is similar to CtrlSF
let g:grepper.side = 0
" }
" { Quickfix-Reflector
" Edit files within any quickfix window, then save to dynamically update files
" Works very similar to CtrlSF, but with quickfix rather than own window
" Maybe I should just use :Doline (vim-qf) or :cdo instead
" Plug 'stefandtw/quickfix-reflector.vim'
" }
" { vim-simple-todo
" Plug 'vitalk/vim-simple-todo'  " Shortcuts to creating todo lists
" let g:simple_todo_map_keys = 0
" " map gs :topleft 12split ~/.scratch<CR>
" map gsh :topleft split ~/habits.scratch.md<CR>
" map gss :topleft split ~/.scratch.md<CR>
" map gsp :topleft split ~/personal.scratch.md<CR>
" map gsw :topleft split ~/work.scratch.md<CR>
" augroup simpletodo
"   autocmd!
"   autocmd BufEnter   *.scratch nmap <buffer> [[ <Plug>(simple-todo-new-start-of-line)i
"   autocmd BufEnter   *.scratch nmap <buffer> ,i <Plug>(simple-todo-new-start-of-line)i
"   autocmd BufEnter   *.scratch nmap <buffer> ,o <Plug>(simple-todo-below)
"   autocmd BufEnter   *.scratch nmap <buffer> <leader>x <Plug>(simple-todo-mark-switch)
"   autocmd BufEnter   *.scratch nmap <buffer> <leader><leader>X :%g/\[x\]/d<CR>
"   " autocmd BufEnter *.scratch imap <buffer> [[ :norm o<CR><Plug>(simple-todo-new)i
"   " autocmd BufEnter *.scratch imap <buffer> ,i :norm o<CR><Plug>(simple-todo-new)i
"   " autocmd BufEnter *.scratch imap <buffer> ,o :norm o<CR><Plug>(simple-todo-new)i
"   autocmd BufEnter   *.scratch imap <buffer> [[ <Plug>(simple-todo-new)
"   autocmd BufEnter   *.scratch imap <buffer> ,i <Plug>(simple-todo-new)
"   autocmd BufEnter   *.scratch imap <buffer> ,o <Plug>(simple-todo-new)
"   autocmd BufLeave   *.scratch w
"   autocmd BufEnter   *.scratch abbreviate <buffer> [ [ ]
"   autocmd BufRead    *.scratch setlocal foldlevel=0
" augroup END
" }
" { Codi
Plug 'metakirby5/codi.vim'  " Interactive scratch pad, similar to Quokka
nmap <leader><leader>r :Codi!!<CR>
let g:codi#aliases = {
      \ 'javascript.jsx': 'javascript',
      \ }
" }
" { Commentary
" Comment out a line of code with <c-/>
Plug 'tpope/vim-commentary'
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary
" }
" { vim-better-whitespace
" Strip trailing whitespace on save
" Plug 'ntpeters/vim-better-whitespace'
" autocmd BufEnter * EnableStripWhitespaceOnSave
" }
" { GoldenView
" Auto resize windows when switching windows
" Plug 'zhaocai/GoldenView.Vim'
" let g:goldenview__enable_default_mapping = 0
" " nmap <silent> <C-S>  <Plug>GoldenViewSplit
" " nmap <silent> <leader>m   <Plug>GoldenViewSwitchMain
" " nmap <silent> <leader><leader>m <Plug>GoldenViewSwitchToggle
" " nmap <silent> <C-N>  <Plug>GoldenViewNext
" " nmap <silent> <C-P>  <Plug>GoldenViewPrevious
" }
" { Vim Deus (colorscheme)
Plug 'ajmwagar/vim-deus'
" }
" { vim-indent-object
" Indentation object: cai, cii, vai, vii, dai, dii, etc.
" Also: aI to select one line above and below, to get e.g. an HTML tag name.
Plug 'michaeljsmith/vim-indent-object'
" }
" { Eunuch
" Commands like :Rename, :Delete, :Mkdir, :Find
Plug 'tpope/vim-eunuch'
" }
" { Vim-Repeat
" Repeat more sensible commands with .
Plug 'tpope/vim-repeat'
" }
" { Neoformat (Prettier)
Plug 'sbdchd/neoformat'
let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--trailing-comma all', '--no-bracket-spacing'],
            \ }
            " \ 'args': ['--trailing-comma all', '--no-bracket-spacing', '--single-quote', '--no-semi'],
            " \ 'args': ['--trailing-comma all', '--no-bracket-spacing'],
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
nmap <silent> = :Neoformat prettier<CR>:w<CR>
" vmap <silent> = :Neoformat prettier<CR>
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
" }
" { ALE
Plug 'w0rp/ale'  " Async linting
let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
let g:ale_javascript_eslint_use_global = 1
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \}
" }
" { yankstack
" Plug 'maxbrunsfeld/vim-yankstack'  " Clipboard history by repeating <leader>p, was still remapping s key when I told it not to
" let g:yankstack_map_keys = 0
" " Remove S as a yank key, otherwise interferes with vim surround S in visual
" let g:yankstack_yank_keys=['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste
" }
" { Tagbar
Plug 'majutsushi/tagbar'
map + :Tagbar<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_case_insensitive = 1
" }
" { Gutentags
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['*node_modules*', '*bower_components*', 'tmp*', 'temp*', 'package*json']
" }
" { vim-visual-star-search
" Allow you to use * and # on visually selected text
Plug 'nelstrom/vim-visual-star-search'
" }
" { vim-lastplace
" Open files at last closed position
Plug 'farmergreg/vim-lastplace'
" }

" -----------------------------------------------------------------------------------------
" 3 - Decent
" -----------------------------------------------------------------------------------------
" " { CtrlSF
" Plug 'dyng/ctrlsf.vim'
" map <F3> :CtrlSF -R ""<LEFT>
" " vmap <leader>8 "hy:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
" " nmap <leader>8 "hyiw:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
" " nmap <leader>/ :CtrlSF -R ""<LEFT>
" " nmap <leader><leader>/ :CtrlSF -R "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" let g:ctrlsf_confirm_save = 0
" " }
" { Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let s:prevcountcache=[[], 0]
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
" let g:airline_theme='minimalist'
" let g:airline_theme='deus'
" let g:airline_theme='hybrid'
" let g:airline_theme='dracula'
let g:airline_theme='jellybeans'
let g:airline_section_a = '%{expand("%:p:t")}'
let g:airline_section_b = '%{expand("%:p:h:t")}'
let g:airline_section_c = '%{expand("%:p:h:h:t")}'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline_inactive_collapse = 0
" }
" { vim-sleuth
" Auto set file tab settings based on current file or other files in directory
Plug 'tpope/vim-sleuth'
" }
" { matchit
" Use % to match HTML tags
Plug 'tmhedberg/matchit'
" }
" { vim-colorschemes
" Big bundle of colorschemes to play with
Plug 'flazz/vim-colorschemes'
" }
" { incsearch
" Extended search and fuzzy search
" Fuzzy search allows you to exclude spaces and such
" While searching, <c-j> can go to next PAGE of matches before pressing enter
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
" }
" { Vim-Sneak
Plug 'justinmk/vim-sneak'
nmap s <Plug>SneakLabel_s
nmap S <Plug>SneakLabel_S
" map s <Plug>Sneak_s
" map S <Plug>Sneak_S
let g:sneak#label = 1
" let g:sneak#s_next = 1
" let g:sneak#target_labels = ";sftunq/SFGHLTUNRMQZ?0"
let g:sneak#target_labels =   "sdfioweqertphjklzxcvnm"
" }
" { rhysd/clever-f.vim
Plug 'rhysd/clever-f.vim'
" }
" { Dash.app
Plug 'rizzatti/dash.vim'
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = {
      \ 'javascript' : [ 'javascript', 'react', 'materialui', 'rxjs', 'lodash', 'css' ]
      \ }
" }
" { Vim Trailing Whitespace
Plug 'bronson/vim-trailing-whitespace'
" }
" " { winresizer
" Plug 'simeji/winresizer'  " <c-e> and then h/j/k/l and <enter> to resize window easier
" " }
" " { visual-split
" " Alternatively, open a new buffer similarly that syncs: https://github.com/chrisbra/NrrwRgn
" Plug 'wellle/visual-split.vim'  " Get a perfectly sized split for a section by selecting and doing <leader>s
" " vmap <leader>s :'<,'>VSSplitAbove<CR>
" vmap v :'<,'>VSSplitAbove<CR>
" " }
" { Colorscheme switcher
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
noremap <F9> :RandomColorScheme<CR>:colo<CR>
" }
" { matchmaker
" Highlight word under cursor
Plug 'qstrahl/vim-matchmaker'
let g:matchmaker_enable_startup = 1
let g:matchmaker_matchpriority = 1
" }
" { Auto-Pairs
" Auto close brackets
" Great until you want to do a macro or enclose existing text
Plug 'jiangmiao/auto-pairs'
" }
" { FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
" " nnoremap <silent> <c-f> :BLines<CR>
" let g:fzf_buffers_jump = 1
" nnoremap <c-p> :Files src/<CR>
" nnoremap <c-b> :Buffers<CR>
" " nnoremap <c-f> :BLines<CR>
" }
" { Vim Maximizer
Plug 'szw/vim-maximizer'
nmap <leader>f :MaximizerToggle<CR>
nmap <leader>z <bar>_
nmap <leader>= =
" augroup maximizepane
"   autocmd!
"   autocmd BufWinEnter,WinEnter *{.js,/} :norm |<CR>
"   autocmd BufWinEnter,WinEnter *{.js,/} :norm _<CR>
" augroup END
" }

" -----------------------------------------------------------------------------------------
" 4 - Could do without
" -----------------------------------------------------------------------------------------
" { Gundo
" Use :Gundo to time travel undo history
Plug 'sjl/gundo.vim'
nmap <leader>u :GundoToggle<CR>
" }
" { Tabular
" Uses :Tabularize /character(s)
Plug 'godlygeek/tabular'
vmap gt :Tabularize /
" }
" { javascript-libraries-syntax
" Adds some minor extra syntax highlighting for certain libraries
" Seems pretty minor, like I noticed React in React.Component was highlighted
Plug 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'lodash,react,flux,d3'
" }
" { Dracula (colorscheme)
Plug 'dracula/vim'
" }

" -----------------------------------------------------------------------------------------
" 5 - New / Evaluating
" -----------------------------------------------------------------------------------------
" { tpope/vim-jdaddy
" gqaj - Pretty print json
Plug 'tpope/vim-jdaddy'
" }
" { kana/vim-textobj-user
Plug 'kana/vim-textobj-user'
" }
" { Goyo
" Dark room, remove distracting Vim elements
Plug 'junegunn/goyo.vim'
nmap <leader>d :Goyo<CR>
" }
" { BufSurf
" Buffer history navigation
" Plug 'ton/vim-bufsurf'
" nmap H :BufSurfBack<CR>
" nmap L :BufSurfForward<CR>
" }
" { vim-renamer
" Rename and move files and folders in batch as plain text
" :Renamer
Plug 'qpkorr/vim-renamer'
nmap <leader><leader>r :Renamer<CR>
" }
" { Vim-Rooter
" Change directory to project root if you are in a subfolder
let g:rooter_patterns = ['app.js']
Plug 'airblade/vim-rooter'
" }
" { thameera/vimv
" Alternative to vim-renamer
Plug 'thameera/vimv'
" }
" { Vim-Test
Plug 'janko-m/vim-test'
nmap <silent> ,t :TestFile<CR>
" tnoremap <Leader><ESC> <C-\><C-n>
let g:test#runners = {'javascript': ['jest']}
let g:test#javascript#karma#file_pattern = 'jest'
let g:test#javascript#jest#file_pattern = '.test.js$'
let g:test#javascript#jest#executable = 'npm test'
let g:test#strategy = "neovim"
" let test#strategy = "neoterm"
" let test#strategy = "dispatch"
let test#javascript#jest#options = {
\ 'suite': '--bail',
\}

" }
" { BufExplorer
nmap <leader><leader>b :BufExplorer<CR>gg4j
Plug 'jlanzarotta/bufexplorer'
let g:bufExplorerDisableDefaultKeyMapping = 1
" }
" { djoshea/vim-autoread
Plug 'djoshea/vim-autoread'
" }
" { edkolev/tmuxline.vim
" Use your Airline theme automatically in Tmux
Plug 'edkolev/tmuxline.vim'
" }
" { yegappan/mru
Plug 'yegappan/mru'
nmap <leader><leader>p :MRU<CR>
" }
" { plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_level = 2
let g:vim_markdown_folding_disabled = 0
map gt :Toch<CR>
map gsh :topleft split ~/notes/habits.scratch.md<CR>
map gsl :topleft split ~/notes/links.scratch.md<CR>
map gsm :topleft split ~/notes/meetings.scratch.md<CR>
map gsp :topleft split ~/notes/personal.scratch.md<CR>
map gsr :topleft split ~/notes/queries.rest<CR>
map gss :topleft 5split ~/notes/task.scratch.md<CR>
map gst :topleft 1split ~/notes/task.scratch.md<CR><c-w>p
map gsv :topleft split ~/notes/vim.scratch.md<CR>
map gsw :topleft split ~/notes/work.scratch.md<CR>

augroup markdown
  autocmd!
  autocmd BufLeave   *.md silent w
augroup END
" }
" { vimwiki/vimwiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_map_prefix = '<Leader>e'
augroup vimwiki
  autocmd!
  autocmd BufLeave   *.wiki silent w
augroup END
" }
" { vim-qf
" Enhancements to the Quickfix window
" Better behavior, like closing Vim if quickfix is last window
" :Keep or :Reject to filter quickfix
" :Dolines or :Dofiles to perform :cdo/:ldo on lines or just the files
Plug 'romainl/vim-qf'
" }
" { vim-qlist
" :Ilist - Add word under cursor to quickfix
" [I - Same thing
Plug 'romainl/vim-qlist'
" }
" { embear/vim-localvimrc
" Put a .lvimrc file in a project to have project specific settings
" Example settings:
" set path+=actions/
" set path+=components/forms/**
" augroup localfilemarks
"   autocmd!
"   autocmd BufEnter */parsers/*       normal! mP
"   autocmd BufEnter */epics/*         normal! mE
" augroup END
Plug 'embear/vim-localvimrc'
let g:localvimrc_ask = 0
augroup localvimrc
  autocmd!
  autocmd BufWinEnter *      silent LocalVimRC
augroup END
" }

call plug#end()
" }

" { Buffers and Find
" Tips:
" Add searches to buffers GrepperAg, then load all to buffer with: :cdo badd %
" Delete all buffers: :bufdo bd
" * C-A to auto complete all glob matches, e.g. :bd **/*<CA>
nmap <leader>c :bdelete!<CR>
nmap <leader><leader>a :%argdelete<CR>
nmap <leader>a :args **/**<LEFT>
nmap <leader>! :argdo<space>
nmap <silent> <leader><leader>c :%bdelete!<CR>
nmap <leader><leader>f :filter // ls<LEFT><LEFT><LEFT><LEFT>
noremap <c-p> :find *
noremap <leader>p :find *
nmap <leader><leader>b :ls h<CR>:b
noremap <leader>b :b<space>

nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=env/,dist/,bower_components/,tmp/,jest/
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*__Scratch__ " scratch.vim
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/**/*,*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
" }


" { Languages

" { Python
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
  autocmd FileType python map <buffer> ,r :Dispatch python %:p<CR>
augroup END
" }

" { Other Languages
autocmd! Syntax java map <F1> :!javac %:p && java HelloWorld<CR>
autocmd! Syntax ruby map <F1> :!./bin/rails server<CR>
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }

" }

" { File Marks
" Automatically bookmark last files accessed by directory
augroup globalfilemarks
  autocmd!
  autocmd BufEnter *.{js,jsx,coffee} normal! mJ
  autocmd BufWinLeave */src/* normal! mQ
  autocmd InsertEnter */src/* normal! mI
  autocmd TextChanged */src/* normal! mO
  autocmd TextChangedI */src/* normal! mO
augroup END
" }

" { Mappings

" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

  let ascii_code = char2nr(a:character)
  if ascii_code >= 48 && ascii_code <= 57
    return 0
  elseif ascii_code >= 65 && ascii_code <= 90
    return 0
  elseif ascii_code >= 97 && ascii_code <= 122
    return 0
  elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
    return 0
  endif

  return 1

endfunction

function! LetMeDuckThatForYou(defaultPhrase)
  " let search = UrlEncode(a:foo)
  " let search = 'foo'
  " echo 'sp term://elinks https://www.google.com/search?q=' . search
  " execute 'sp term://surfraw google ' . search
  " execute 'sp term://elinks www.google.com/search?q=' . search
  " execute 'sp term://elinks www.google.com/search?q=foo'
  " execute 'sp term://googler --count 2 ' . search
  " execute 'norm :sp term://googler --count 2 ' . search
  " call feedkeys(":sp")
  " call feedkeys(':sp term://googler --count 2 ' . a:foo)
  " call feedkeys(':vsp term://env BROWSER=elinks googler --count 3 ' . a:foo)
  " let searchCommand = ':vsp term://env BROWSER=w3m googler --count 3 '

  " let searchCommand = ':vsp term://env BROWSER=elinks googler --count 3 '
  " let searchCommand = searchCommand . a:foo

  call inputsave()
  let phrase = input('', a:defaultPhrase)
  call inputrestore()

  let searchCommand = ':vsp term://elinks duckduckgo.com/?q='
  let searchCommand = searchCommand . UrlEncode(phrase)

  execute '!open https://duckduckgo.com/?q=' . UrlEncode(phrase)
endfunction

" { Terminal
nmap <silent> <leader>t :sp term://fish<CR>i
nmap ,b :sp term://bash %:p<CR>
nmap ,r :sp term://npm start<CR>
map ,q :sp term://env NODE_ENV=qa npm start<CR>
augroup vimux
  autocmd!
  autocmd BufEnter */api/* map <buffer> ,r :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,q :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,t :sp term://npm test -- --tests " . expand("%"))<CR>
" map ,t :Dispatch npm test<CR>
augroup END
nmap <leader>O :call LetMeDuckThatForYou(&filetype . ' ' . '<c-r><c-w>')<CR>
nmap <leader>o :call LetMeDuckThatForYou('')<CR>
vmap <leader>o y:call LetMeDuckThatForYou(&filetype . ' ' . @+)<CR>
nmap <C-\> <C-\><C-n> :wincmd p<CR>
tnoremap <C-\> <C-\><C-n>
tnoremap <C-h> <C-\><C-n>:wincmd h<CR>
tnoremap <C-j> <C-\><C-n>:wincmd j<CR>
tnoremap <C-k> <C-\><C-n>:wincmd k<CR>
tnoremap <C-l> <C-\><C-n>:wincmd l<CR>
" }

function! SetScratchBuffer()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction
function! DiffThis()
  normal! ?^<<<<<<<
  normal! j
  normal! V
  normal! /^=======
  normal! k
  normal! "ay

  /^=======
  normal! j
  normal! V
  /^>>>>>>>
  normal! k
  normal! "by
  normal! 

  silent split /tmp/a.js
  call SetScratchBuffer()

  normal! ggVGd
  normal! "aP
  diffthis

  silent vsplit /tmp/b.js
  call SetScratchBuffer()

  normal! ggVGd
  normal! "bP
  diffthis

endfunction

" { Leader <Space>

" copy current absolute filename into register
nnoremap <leader>yf :let @*=expand('%:p')<CR>
" copy file contents
" nnoremap <leader>yf :%y+<cr>

nmap <leader><leader>i :PlugInstall<CR>
nmap <leader><leader>u :PlugClean!<CR>
nmap <leader>ev :vsp ~/.config/nvim/init.vim<CR>
nmap <leader><leader>t :sp ~/dotfiles/.ctags<CR>

nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>
nmap <leader>h :sp<CR>
nmap <leader>v :vsp<CR>
nmap <leader>w :w<CR>

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

" }

" { Visual Mode
vmap I :norm I
vmap A :norm A
vmap <enter> :norm<space>
vmap <bar> :g/
nmap <leader>l yiw{oconsole.warn(`"`, ")^
vmap <leader>l y{oconsole.warn(`"`, ")^
vnoremap <c-p> :<c-p>
" }

map ! :!

" { Navigation in buffer
map J <c-d>
map K <c-u>
map H [{
map L ]}
" }

" { Navigate panes
" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l
" }

imap <c-z> <c-y>,

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" }

" { Default behavior overrides

nmap <enter> vap

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('rg')
  set grepprg=rg
elseif executable('ack')
  set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
endif

" When doing commands, always scroll through history matching current text
cmap <c-p> <up>
cmap <c-n> <down>

" noremap ; :

nnoremap g} :split<CR>gd

" Case insensitive search (but still have case sensitive for :substitute
nnoremap / /\c
vnoremap / /\c
nnoremap ? ?\c
vnoremap ? ?\c

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Center screen and open folds when going through search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

" Y should copy to end of line, not full line, same as D
noremap Y y$

nmap [q :cprev<CR>
nmap ]q :cnext<CR>
nmap [b :bprevious<CR>
nmap ]b :bnext<CR>
nmap [a :previous<CR>
nmap ]a :next<CR>

" }


" { Functions
" Automatically create directories that don't exist if doing
" e.g. :e ./path/that/doesnt/exist/bar.js
function! <SID>AutoMkdir() abort
  let l:dir = expand('<afile>:p:h')
  let l:file = expand('<afile>:t')
  if !isdirectory(l:dir)
    call mkdir(l:dir, 'p')
    silent execute 'bw ' . l:dir . '/' . l:file
    silent execute 'e ' . l:dir . '/' . l:file
  endif
endfunction
augroup AutoMkdir
  autocmd!
  autocmd BufWritePre,FileWritePre,BufNewFile *
        \ call <SID>AutoMkdir()
augroup END

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
" nnoremap <silent> <C-A> :ZoomToggle<CR>

" }

" { Abbreviations
abbreviate --- -----------------------------------------------------------------------------------------
" }

" { Colorscheme
set termguicolors
set background=dark

" " colorscheme beekai
" " colorscheme badwolf
" " colorscheme molokai
" " colorscheme Monokai
" " colorscheme void
" " colorscheme sift
" " colorscheme darkburn
" syntax on
" " colorscheme null
" " colorscheme predawn
" " colorscheme zenburn
" " colorscheme elflord
" colorscheme darkblue
" colorscheme jellybeans
" colorscheme distinguished
" colorscheme vividchalk
" colorscheme gruvbox
" colorscheme dracula
" colorscheme solarized
" colorscheme darkblue
colorscheme monokai
" colorscheme deus
" colorscheme flattr
" colorscheme onedark
" " } Colorscheme

" " { Highlights
" " These come after Colorscheme so they don't get overwritten
" "
" " { Background
" highlight Normal guibg=#282828
" }
"
" { Comments
highlight Comment guifg=#999999
" }
"
" { Current line
" set cursorline
" highlight cursorLine term=bold cterm=bold guibg=#333333
" }
" { Column 80
set colorcolumn=
highlight ColorColumn ctermbg=240 guibg=#3a3a3a
" }

" { vim_current_word
" highlight CurrentWord term=reverse ctermfg=235 ctermbg=214 guifg=#282828 guibg=#fabd2f
" highlight CurrentWordTwins guibg=#587474 gui=underline  ctermbg=2 cterm=underline
" }
" { gitgutter
highlight GitGutterAdd          guibg=#505050
highlight GitGutterChange       guibg=#505050
highlight GitGutterDelete       guibg=#505050
" }
" { matchmaker
hi default Matchmaker term=underline    ctermbg=238     guibg=#555555
" }
" { Numbers
hi LineNr guifg=#777777
" }
" " { Search
highlight IncSearch      cterm=reverse ctermfg=184 ctermbg=234 gui=reverse guifg=#f05050 guibg=#505050
highlight Search         ctermfg=0     ctermbg=220             gui=reverse guifg=#f08080 guibg=#505050
" " }
" }

" { Macros / macro-like mappings

" Convert React stateless functional class to a full stateful class
" map \c j?constcwclasswea extends React.component ldt{oconstructor(props) {super(props);this.state = {};}render() {]}O}v%:s/props/this.props=
" map \f j?classcwconstelct{ = (props) => /constructor$V%d/render$%dddd[{v%:s/this.props/props
" map \m yiw20HopA() {}k
"OpA() {}
" }
" }

" { Conceal
set conceallevel=2
set concealcursor=vnc
" }

" { Folding
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
" }
" }

" { Text Objects
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
" }
" }

" { .vimrc / init.vim
augroup config
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd BufWritePost init.vim source % | setlocal foldmethod=marker
  autocmd BufWritePost init.vim set modeline | doautocmd BufRead
  " autocmd BufReadPost init.vim normal `.
augroup END
" }

