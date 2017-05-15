"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE SURE TO DO THIS IN YOUR FISH SHELL CONFIG: set -x TERM xterm-256color
" MAKE SURE TO USE Source Code Pro FONT IN YOUR TERMINAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-reload VIMRC
autocmd! bufwritepost .vimrc source %

set noswapfile
set autoread
set nowrap
set noautochdir "Some plugins don't work with this enabled, like vimfiler or vimshell
syntax on
set nolist
set background=dark
colorscheme sift

set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" set mouse=a " Allows mouse click to move cursor, but it makes it harder to copy text
set virtualedit=all "allow cursor to stay in same column while scrolling
" set clipboard=unnamedplus " allow copy/paste using system clipboard (otherwise have to use "+)
set clipboard=unnamed " allow copy/paste using system clipboard (otherwise have to use "+)
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent
set backspace=indent,eol,start
set scrolloff=17 "Keep cursor centered
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
set nonumber

set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set wildcharm=<TAB>

set wildmenu
set wildmode=full
set wildchar=<Tab>

" Always show the statusline
set laststatus=2
set statusline=%-20t
set statusline+=%=        " Switch to the right side
set statusline+=(%f)
" set statusline+=%{fugitive#statusline()}

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme='serene'

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_auto_jump = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args="--ignore=C901,E501,E128,E202,E203,E226,E127,F401,E401,E302,E221,F811,E201,E126,F841,W293,W391 --max-complexity 10"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './odyssey/node_modules/eslint/bin/eslint.js'

set incsearch
set hlsearch
set noignorecase              " affects both searching and find/replace
set smartcase

set nocompatible              " be iMproved, required
filetype off                  " required

set foldmethod=indent
set foldnestmax=8
"set foldlevelstart=20
set foldlevelstart=99

set conceallevel=0
set concealcursor=vin

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'mxw/vim-jsx'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'tmhedberg/matchit'
Bundle 'lambacck/python_matchit'
Bundle 'tpope/vim-fugitive'
Bundle 'rking/ag.vim'
Bundle 'Chun-Yang/vim-action-ag'
Bundle 'majutsushi/tagbar'
Bundle 'airblade/vim-gitgutter'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'qstrahl/vim-matchmaker'
Bundle 'haya14busa/incsearch.vim'
Bundle 'tpope/vim-commentary'
Bundle 'honza/vim-snippets'
Bundle 'Chiel92/vim-autoformat'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'flazz/vim-colorschemes'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'gregsexton/gitv'
Bundle 'vim-scripts/MultipleSearch'
Bundle 'int3/vim-extradite'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-sleuth'
Bundle 'pangloss/vim-javascript'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'dyng/ctrlsf.vim'
Bundle 'rubik/vim-radon'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'ervandew/supertab'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mattn/emmet-vim'
Bundle 'derekwyatt/vim-scala'
call vundle#end()
filetype plugin indent on    " required

" """"""""""""""""""""""""""""""""
" "" Ctrl P
" """"""""""""""""""""""""""""""""
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" Using ag is faster, BUT wildignore doesn't work
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_use_caching = 0
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rst|pyc)$'
set wildignore+=*/env/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*/jest/*,*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
let g:ctrlp_working_path_mode = 'a'


" """"""""""""""""""""""""""""""""
" "" Python
" """"""""""""""""""""""""""""""""
let g:pymode_options_max_line_length=120
let python_highlight_all=1
autocmd Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
autocmd Syntax python setlocal foldmethod=indent
autocmd Syntax python normal zR
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR


" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Explore using "-" key
noremap - :e %:p:h<CR>

map <F1> :cp<CR>
map <F2> :Ag 
map <F3> :cn<CR>
map <F4> :Ag 
map <F4> "hyiw:Ag <c-r>h<CR>
inoremap <F5> <ESC>:wa<CR>:!clear<CR>:!%:p<CR>
nnoremap <F5> :wa<CR>:!clear<CR>:!%:p<CR>
vnoremap <F5> :w !bash<BAR>less<CR>
noremap <F6> :!tig %<CR>
noremap <F7> :SyntasticCheck<CR>:Errors<CR>
set pastetoggle=<F9> " Paste text from other places safely
noremap <Leader><F7> :SyntasticReset<CR>
noremap <silent> <F8> :!clear;python %<CR>
noremap <F10> :!pudb %<CR>

" nmap z 5<c-w>+5<c-w>>
nmap = <c-w>=

" Use Space bar for leader key
let mapleader = "\<Space>"

map <leader>c :q<CR>
map <leader>d :sp<CR>:YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>p :set paste!<CR>
map <leader>l :set list!<CR>
map <leader>q :q<CR>
map <leader>r :!py.test %:p<CR>
map <leader>s :sp<CR>
map <leader>t :tabnew<CR>
map <leader>v :vsp<CR>
map <leader>w :w<CR>
map <leader><leader>j :join<CR>
map <leader><leader>s :UltiSnipsEdit<CR>
map <leader><leader>v :sp ~/.vimrc<CR>
map <leader>/ "hyiw:Ag <c-r>h<CR>:nohlsearch<CR>

" Diff put to grab changes using comma
noremap , :diffput<CR>

map gC :Gcommit<CR>i
map gP :Gpush<CR>
map ge :Gedit<CR>
map gs :Gstatus<CR>
map gb :Gblame<CR>
map gd :Gdiff<CR>
map gR :Gread<CR>
map gw :Gwrite<CR>
map gl :Extradite<CR>
map gL :Glog<BAR>:bot copen<CR>

" noremap <leader>l g;999g,
" noremap <c-n> g;
noremap <leader>n 999g,
noremap <c-f> :cnext<CR>
noremap <c-b> :cprev<CR>

" Comment out a line of code
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary

" Center screen when going through search results
nnoremap n nzz
nnoremap N Nzz

" Keep location of file when reopening
autocmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\       exe 'normal! g`"zvzz' |
\   endif


" Auto indent wasn't working without this on bottom
filetype indent on
set ai
set si


" Prevent browsing in Fugitive from creating a trail of temp file buffers
autocmd BufReadPost fugitive://*
  \ set bufhidden=delete


let g:used_javascript_libs = 'jquery, underscore, backbone, angularjs'

map \ :YcmCompleter GoToDefinitionElseDeclaration<CR><CR>
map <BAR> "hyiw?\(class\s\\|var\\|def\s\).*<c-r>h<CR>:nohlsearch<CR>

" Mark next, based on Vim-Signature
map <Space> m.

map Q :cprev<CR>
map <c-q> :cnext<CR>

let g:ag_highlight=1

" Don't automatically do line breaks on long lines
set formatoptions-=t



" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

" map H <c-w>H
" map J <c-w>J
" map K <c-w>K
" map L <c-w>L
" map J ]c
" map K [c
" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c
" map J }j^
" map K k{j^
map J }
map K {
map H [{
map L ]}


vmap <leader><leader>n :norm
nmap <leader><leader>g :%g/

" map ` @@

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

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

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
map = :call RangerExplorer()<CR>
