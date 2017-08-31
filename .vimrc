" {{{ Options

" Don't use a swapfile
set noswapfile

" Update buffer if file changes outside of Vim, without prompt
set autoread

" Don't wrap normally
set nowrap

" If you enable wrap, break on spaces or tabs
set breakat=\ ^I

" Don't change directory to current buffer.
" Some plugins don't work with this enabled, like vimfiler or vimshell
set noautochdir
set nolist

" Use GUI colors if supported, with more colors available
set termguicolors

" If you open up gVim for whatever reason
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" allow cursor to stay in same column while scrolling
set virtualedit=all

" allow copy/paste using system clipboard (otherwise have to use "+)
if $TMUX == ''  " disable in TMux as it breaks copy / paste and is not needed
  set clipboard=unnamed
endif

" The basics
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent

" Allow backspace to go past beginning of line
set backspace=indent,eol,start

" Keep cursor centered -- this is choppy if scrolling multiple splits
" set scrolloff=17
set cindent
set shell=bash
set more " Use MORE as pager
set lazyredraw
set ttyfast
set ttymouse=xterm2
set showmatch
set splitbelow
set splitright
set gdefault
set confirm
set diffopt=vertical
set hidden
set history=1000
set linebreak
set nojoinspaces
set magic
set browsedir=buffer
set nocursorline
set nobackup
set nowritebackup
set number
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

set conceallevel=0
set concealcursor=vin

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

" Set window title to include current filename.
" Great for use in iterm2: press cmd+shift+o and search for filename of a
" window
set t_ts=]1;
set t_fs=
set title

let mapleader = "\<Space>"

" }}}

" {{{ Plugins
" {{{ List of Plugins (Vim-Plug)
call plug#begin('~/.vim/bundle')
" 1 - Essential
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 2 - Great
Plug 'tpope/vim-vinegar'  " Improve file management with NetRW (press -)
Plug 'vitalk/vim-simple-todo'  " Shortcuts to creating todo lists
Plug 'metakirby5/codi.vim'  " Interactive scratch pad, similar to Quokka

" 3 - Decent

" 4 - Could do without
" Plug 'jiangmiao/auto-pairs'

" 5 - New / Evaluating
Plug 'tpope/vim-sensible'
Plug 'tmhedberg/matchit'
Plug 'lambacck/python_matchit'
Plug 'Chun-Yang/vim-action-ag'
Plug 'qstrahl/vim-matchmaker'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'flazz/vim-colorschemes'
Plug 'gregsexton/gitv'
Plug 'vim-scripts/MultipleSearch'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-sleuth'
Plug 'pangloss/vim-javascript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dyng/ctrlsf.vim'
Plug 'rubik/vim-radon'
Plug 'SirVer/ultisnips'
Plug 'derekwyatt/vim-scala'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'terryma/vim-smooth-scroll'
Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-obsession'
Plug 'posva/vim-vue'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-lang/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'rhysd/clever-f.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'wellle/targets.vim'
Plug 'mhinz/vim-grepper'
" Plug 'mtth/scratch.vim'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-eunuch'
Plug 'sjl/gundo.vim'
" Shouldn't be needed
" since tern is built in to YouCompleteMe now, if using flag
" Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'rizzatti/dash.vim'
" Plug 'moll/vim-node'
Plug 'othree/html5.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer'  }
Plug 'sbdchd/neoformat'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/jspc.vim'
Plug 'w0rp/ale'  " Async linting
" Plug 'scrooloose/nerdtree'  " File browsing with :E . or :NERDTreeFind
Plug 'tpope/vim-rhubarb'  " Adds :Gbrowse to Fugitive for jumping to the Github repo
Plug 'chrisbra/NrrwRgn'  " :NR on selected text to open focused split that syncs
Plug 'simeji/winresizer'  " <c-e> and then h/j/k/l and <enter> to resize window easier
Plug 'benmills/vimux'  "  Run external commands in a small split Tmux pane
Plug 'sheerun/vim-polyglot'  " Collection of language plugins
Plug 'ton/vim-bufsurf'  " Previous buffer history with :BufSurfForward and :BufSurfBackward
Plug 'sickill/vim-pasta'  " Adjust pasted text indentation to match surrounding block, works automatically overriding <p>
Plug 'wikitopian/hardmode'  " :call HardMode() to force yourself to not use single motions
Plug 'dominikduda/vim_current_word'  " Show the currently selected word highlighted
Plug 'wellle/visual-split.vim'  " Get a perfectly sized split for a section by selecting and doing <leader>s
Plug 'maxbrunsfeld/vim-yankstack'  " Clipboard history by repeating <leader>p
Plug 'justinmk/vim-dirvish'  " File manager
Plug 'int3/vim-extradite'
Plug 'farmergreg/vim-lastplace'
Plug 'tpope/vim-dispatch'
call plug#end()
" }}}

" {{{ Plugin Settings

" {{{ Miscellaneous
let g:EasyMotion_smartcase = 1

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let radon_always_on = 0

let g:jsx_ext_required = 0

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:clever_f_across_no_line = 1
let g:clever_f_timeout_ms = 3000

" let g:scratch_persistence_file = expand('$HOME/.scratch')
map gs :topleft 8split ~/.scratch<CR>
" let g:scratch_autohide = 0
" let g:scratch_no_mappings = 1
" let g:scratch_height = 8
" noremap gs :Scratch<CR>
" nnoremap gs :Scratch<CR>

" }}}
" {{{ Codi
nmap <leader>c :Codi!!<CR>
let g:codi#aliases = {
      \ 'javascript.jsx': 'javascript',
      \ }
" }}}
" {{{ Neoformat (Prettier)
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
" {{{ Fugitive / Extradite
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
" {{{ YouCompleteMe
" nmap <silent> gd :YcmCompleter GoTo<CR>
nmap <silent> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" }}}
" {{{ Grepper
let g:grepper = {}
runtime autoload/grepper.vim
let g:grepper.jump = 1
let g:grepper.stop = 500
" }}}
" {{{ Ctrl P
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

let g:ctrlp_cmd = 'CtrlPMRU'
" let g:ctrlp_cmd = 'CtrlPBookmarkDir'
" let g:ctrlp_cmd = 'CtrlPLastMode'
" let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_use_caching = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_default_input = 0
let g:ctrlp_types = ['fil', 'mru']
let g:ctrlp_mruf_exclude = '.*/.vimrc\|/temp/.*' " MacOSX/Linux
let g:ctrlp_mruf_relative = 1

" let g:ctrlp_extensions = ['line', 'changes', 'bookmarkdir']
let g:ctrlp_extensions = []
" Using ag is faster, BUT wildignore doesn't work
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_use_caching = 0
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rst|pyc)$'
" set wildignore+=env/,node_modules/,dist/,bower_components/,tmp/,jest/
set wildignore+=env/,dist/,bower_components/,tmp/,jest/
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*__Scratch__ " scratch.vim
" }}}
" {{{ UltiSnips
" Fix directory UltiSnipsEdit places snippets in
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}
" {{{ Airline / Lightline
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
let g:airline_theme='simple'
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
" {{{ ALE
let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
let g:ale_javascript_eslint_use_global = 1
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \}
" }}}
" {{{ CtrlP Funky
let g:ctrlp_funky_syntax_highlight = 1
" }}}
" {{{ FZF
let g:fzf_buffers_jump = 1
" }}}
" {{{ VimFiler
:let g:vimfiler_as_default_explorer = 1
" }}}
" {{{ Vimux / Dispatch
let g:VimuxHeight = "20"
let g:VimuxPromptString = "Vimux>  $ "
map ,v :call VimuxPromptCommand("npm start")<CR>
" Dispatch is better for single tasks, shows quickfix results afterwards
map ,d :Dispatch<SPACE>
map ,i :call VimuxInspectRunner()<CR>
map ,z :VimuxZoomRunner<CR>
" }}}
" {{{ Dash.app
nmap <silent> <leader>d <Plug>DashSearch
let g:dash_map = {
      \ 'javascript' : [ 'javascript', 'react', 'materialui', 'rxjs', 'lodash', 'css' ]
      \ }
" }}}
" {{{ vim-simple-todo
let g:simple_todo_map_keys = 0
augroup simpletodo
  autocmd!
  autocmd BufEnter .scratch nmap <buffer> [[ <Plug>(simple-todo-new-start-of-line)i
  autocmd BufEnter .scratch nmap <buffer> ,i <Plug>(simple-todo-new-start-of-line)i
  autocmd BufEnter .scratch nmap <buffer> ,o <Plug>(simple-todo-below)
  autocmd BufEnter .scratch nmap <buffer> x <Plug>(simple-todo-mark-switch)
  " autocmd BufEnter .scratch imap <buffer> [[ :norm o<CR><Plug>(simple-todo-new)i
  " autocmd BufEnter .scratch imap <buffer> ,i :norm o<CR><Plug>(simple-todo-new)i
  " autocmd BufEnter .scratch imap <buffer> ,o :norm o<CR><Plug>(simple-todo-new)i
  autocmd BufEnter .scratch imap <buffer> [[ <Plug>(simple-todo-new)
  autocmd BufEnter .scratch imap <buffer> ,i <Plug>(simple-todo-new)
  autocmd BufEnter .scratch imap <buffer> ,o <Plug>(simple-todo-new)
  autocmd BufLeave .scratch w
augroup END
" }}}
" {{{ HardMode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader><leader>h <Esc>:call ToggleHardMode()<CR>
" }}}
" {{{ visual-split
vmap <leader>s :'<,'>VSSplitAbove<CR>
" }}}
" {{{ yankstack
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" }}}
" {{{ Vinegar / Dirvish / Ranger

" noremap - :e %:p:h<CR>
noremap - :Dirvish %<CR>
let g:dirvish_relative_paths = 1

" noremap _ :RangerEdit<CR>
" noremap - :RangerEdit<CR>

" }}}


"
" }}}

" }}}

" {{{ Languages

" {{{ Python
let g:pymode_options_max_line_length=120
let python_highlight_all=1
autocmd! Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
autocmd! Syntax python setlocal foldmethod=indent
autocmd! Syntax python normal zR
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
augroup javascript
  autocmd!
  autocmd FileType javascript,javascript.jsx map ,r :call VimuxRunCommand("npm start")<CR>
  autocmd FileType javascript,javascript.jsx map ,t :Dispatch npm test<CR>
augroup END
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
map <F3> :GrepperAg ""<LEFT>
" map <F4> "hyiw:GrepperAg <c-r>h<CR>
" map <F4> "hyiw:Ag <c-r>h
map <F5> :NERDTreeToggle<CR>
noremap <F6> :!tig %<CR>
nmap <F7> "hyiw:!open 'https://www.google.com/search?newwindow=1&site=&source=hp&q=<c-r>h'
vmap <F7> "hy:!open 'https://www.google.com/search?newwindow=1&site=&source=hp&q=<c-r>h'
noremap <F9> :RandomColorScheme<CR>:colo<CR>
map <F12> "hyiw:Dash <c-r>h<CR>
vmap <F12> "hy:Dash <c-r>h<CR>
" }}}

" {{{ Leader <Space>



" map <leader>/ "hyiw:Ag
map <leader>/ "hyiw:GrepperAg ""<LEFT>
map <leader>8 "hyiw:Ag <c-r>h<CR>:nohlsearch<CR>
map <leader><leader>8 "hyiw:GrepperAg <c-r>h<CR>:nohlsearch<CR>
map <leader><leader>i :PlugInstall<CR>
map <leader><leader>j :join<CR>
map <leader><leader>s :UltiSnipsEdit<CR>
map <leader><leader>u :PlugClean!<CR>
map <leader><leader>v :sp ~/.dotfiles/.vimrc<CR>
map <leader><leader>w :ToggleWorkspace<CR>
" map <leader>c :q<CR>
map <leader>f :ALEFix<CR>
" map <leader>l :set list!<CR>
" map <leader>o :copen<CR>
map <leader>oo !open https://www.google.com/search?q=javascript+
map <leader>oh !open https://github.com/search?q=
map <leader>on "pyi":!open https://www.npmjs.com/package/p
" map <leader>p :set paste!<CR>
map <leader>q :q<CR>
nmap <leader>s :sp<CR>
map <leader>t :NERDTreeFind<CR>
map <leader>u :GundoToggle<CR>
map <leader>v :vsp<CR>
map <leader>w :w<CR>

" Diff put to grab changes using comma
" noremap , :diffput<CR>

" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c
map <leader>0 :set foldlevel=0<CR>
map <leader>1 :set foldlevel=1<CR>
map <leader>2 :set foldlevel=2<CR>
map <leader>3 :set foldlevel=3<CR>
map <leader>4 :set foldlevel=4<CR>
map <leader>5 :set foldlevel=5<CR>
map <leader>6 :set foldlevel=6<CR>
map <leader>7 :set foldlevel=7<CR>
" map <leader>8 :set foldlevel=8<CR>
map <leader>9 :set foldlevel=999<CR>

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

" Comment out a line of code with <c-/>
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary

" Center screen when going through search results
" nnoremap <silent> n nzz
" nnoremap <silent> N Nzz

map \ :YcmCompleter GoToDefinitionElseDeclaration<CR>

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

noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2, 35, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2, 35, 1)<CR>

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

nmap gr "hyiw:GrepperAg <c-r>h<CR>
nmap gR :YcmCompleter GoToReferences<CR>

map ; :

" }}}

" {{{ Functions

" I'm trying out this instead: michaeljsmith/vim-indent-object
" " Use e.g. vai to select everything of same indent level
" " http://vim.wikia.com/wiki/Creating_new_text_objects
" " http://vim.wikia.com/wiki/Indent_text_object
" " http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
" onoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR>
" onoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR>
" vnoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR><Esc>gv
" vnoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR><Esc>gv
" function! s:IndTxtObj(inner)
"   let curline = line(".")
"   let lastline = line("$")
"   let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
"   let i = i < 0 ? 0 : i
"   if getline(".") !~ "^\\s*$"
"     let p = line(".") - 1
"     let nextblank = getline(p) =~ "^\\s*$"
"     while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
"       -
"       let p = line(".") - 1
"       let nextblank = getline(p) =~ "^\\s*$"
"     endwhile
"     normal! 0V
"     call cursor(curline, 0)
"     let p = line(".") + 1
"     let nextblank = getline(p) =~ "^\\s*$"
"     while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
"       +
"       let p = line(".") + 1
"       let nextblank = getline(p) =~ "^\\s*$"
"     endwhile
"     normal! $
"   endif
" endfunction

" if !exists('*RangerExplorer')
"   function RangerExplorer()
"       exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
"       if filereadable('/tmp/vim_ranger_current_file')
"           exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
"           call system('rm /tmp/vim_ranger_current_file')
"       endif
"       redraw!
"   endfun
" endif
" map = :call RangerExplorer()<CR>

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

" }}}

" {{{ Colorscheme
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
" set background=dark
" colorscheme zenburn
" colorscheme elflord
colorscheme gruvbox
" }}} Colorscheme

" autocmd! bufwritepost .vimrc source % | AirlineRefresh | setlocal foldmethod=marker
augroup vimrc
  autocmd!
  " autocmd bufwritepost .vimrc source % | setlocal foldmethod=marker
  autocmd bufwritepost .vimrc source % | setlocal foldmethod=marker
  autocmd BufRead,BufNewFile .vimrc setlocal foldmethod=marker
augroup END
