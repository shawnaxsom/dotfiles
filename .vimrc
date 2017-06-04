"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE SURE TO DO THIS IN YOUR FISH SHELL CONFIG: set -x TERM xterm-256color
" MAKE SURE TO USE Source Code Pro FONT IN YOUR TERMINAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-reload VIMRC
autocmd! bufwritepost .vimrc source %

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'mxw/vim-jsx'
Bundle 'scrooloose/syntastic'
Bundle 'ctrlpvim/ctrlp.vim'
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
Bundle 'gregsexton/gitv'
Bundle 'vim-scripts/MultipleSearch'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-sleuth'
Bundle 'pangloss/vim-javascript'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'dyng/ctrlsf.vim'
Bundle 'rubik/vim-radon'
Bundle 'ervandew/supertab'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mattn/emmet-vim'
Bundle 'derekwyatt/vim-scala'
Bundle 'easymotion/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-colorscheme-switcher'
Bundle 'jiangmiao/auto-pairs'
Bundle 'junegunn/gv.vim'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'tpope/vim-obsession'
Bundle 'posva/vim-vue'
" Bundle 'itchyny/lightline.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'elixir-lang/vim-elixir'
Bundle 'scrooloose/nerdtree'
Bundle 'leafgarland/typescript-vim'
call vundle#end()
filetype plugin indent on    " required

set noswapfile
set autoread
set nowrap
set noautochdir "Some plugins don't work with this enabled, like vimfiler or vimshell
syntax on
set nolist
set background=dark
" colorscheme beekai
" colorscheme zenburn
" colorscheme badwolf
" colorscheme molokai
" colorscheme molokai_dark
" colorscheme Monokai
" colorscheme gruvbox
colorscheme predawn
" colorscheme onedark
" colorscheme Tomorrow-Night
" colorscheme Tomorrow-Night-Bright

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
set scrolloff=17 "Keep cursor centered -- this is choppy if scrolling multiple splits
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
set completeopt=longest,menuone,preview
set wildcharm=<TAB>

set wildmenu
set wildmode=full
set wildchar=<Tab>

set showtabline=0

" Always show the statusline
set laststatus=2
set statusline=%f
set statusline+=%=        " Switch to the right side
set statusline+=%{fugitive#statusline()}

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

autocmd Syntax java map <F1> :!javac %:p && java HelloWorld<CR>
" autocmd Syntax javascript map <F1> :!node %:p<CR>
autocmd Syntax ruby map <F1> :!./bin/rails server<CR>
map <F1> :map <F1> :!

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Explore using "-" key
noremap - :e %:p:h<CR>

" map <F1> :cp<CR>
map <F2> :Ag 
" map <F3> :cn<CR>
map <F3> :NERDTreeToggle<CR>
map <F4> :Ag 
map <F4> "hyiw:Ag <c-r>h<CR>
inoremap <F5> <ESC>:wa<CR>:!clear<CR>:!%:p<CR>
nnoremap <F5> :wa<CR>:!clear<CR>:!%:p<CR>
vnoremap <F5> :w !bash<BAR>less<CR>
noremap <F6> :!tig %<CR>
noremap <F7> :SyntasticCheck<CR>:Errors<CR>
noremap <Leader><F7> :SyntasticReset<CR>
noremap <F9> :RandomColorScheme<CR>:colo<CR>
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
map <leader><leader>i :BundleInstall<CR>
map <leader><leader>l :BundleList<CR>
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
map gl :GV!<CR>  " gv.vim
map gL :Glog<BAR>:bot copen<CR>

" noremap <leader>l g;999g,
" noremap <c-n> g;
" noremap <leader>n 999g,
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
" map <BAR> "hyiw?\(class\s\\|var\\|def\s\).*<c-r>h<CR>:nohlsearch<CR>

" Mark next, based on Vim-Signature
map <Space> m.

map Q :cprev<CR>
map <c-q> :cnext<CR>

let g:ag_highlight=1

" Don't automatically do line breaks on long lines
" set formatoptions-=t



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

noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2, 35, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2, 35, 1)<CR>
" noremap <silent> K :call smooth_scroll#up(&scroll/3, 30, 1)<CR>
" noremap <silent> J :call smooth_scroll#down(&scroll/3, 30, 1)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>



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

map  s <Plug>(easymotion-bd-w)

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l

" Fix directory UltiSnipsEdit places snippets in
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

map ! :!

" Use e.g. vai to select everything of same indent level
" http://vim.wikia.com/wiki/Creating_new_text_objects
" http://vim.wikia.com/wiki/Indent_text_object
" http://vimdoc.sourceforge.net/htmldoc/motion.html#text-objects
onoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR>
onoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR>
vnoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR><Esc>gv
function! s:IndTxtObj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction

" F8 to cycle colorschemes with Bundle 'twe4ked/vim-colorscheme-switcher'
" autocmd VimEnter * :silent! SetColors all

let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
if executable("ag")
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

map ; :

imap <c-o> o
nmap <tab> <c-p><CR>

imap <c-z> <c-y>,

" Vue.js .vue file set filetype on load
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'inactive': {
      \   'left': [  [ 'filename' ],
      \              [ 'parentfolder' ],
      \              [ 'pwd' ]]
      \ },
      \ 'active': {
      \   'left': [  [ 'filename' ],
      \              [ 'parentfolder' ],
      \              [ 'pwd' ]],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ },
      \ 'component': {
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'pwd': '%{expand("%:p:h")}',
      \ 'filename': '%t',
      \ 'parentfolder': '%{expand("%:p:h:t")}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&ff}',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'percent': '%3p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%3l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ' } }

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme='simple'
let g:airline_section_a = '%t'
let g:airline_section_b = '%{expand("%:p:h:t")}'
let g:airline_section_c = '%{expand("%:p:h")}'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''

let g:AutoPairsShortcutToggle = '<c-a>'
