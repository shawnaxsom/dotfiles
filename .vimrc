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
set list
set background=dark
colorscheme badwolf
"CSApprox " Show GVim color schemes in 256 bit terminals

set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set mouse=a
set virtualedit=all "allow cursor to stay in same column while scrolling
set clipboard=unnamedplus " allow copy/paste using system clipboard (otherwise have to use "+)
set tabstop=2 shiftwidth=2 shiftround expandtab autoindent smarttab smartindent
set backspace=indent,eol,start
set scrolloff=18 "Keep cursor centered
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
set cursorline
set nobackup
set nowritebackup

set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set wildcharm=<TAB>

set nonumber

set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

set wildmenu
set wildmode=full
set wildignorecase
set wildchar=<Tab>

set laststatus=1
set statusline=%-20t
set statusline+=%=        " Switch to the right side
set statusline+=(%f)

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_auto_jump = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args="--ignore=C901,E501,E128,E202,E203,E226,E127,F401,E401,E302,E221,F811,E201,E126,F841,W293 --max-complexity 10"

set incsearch
set hlsearch

set noignorecase              " affects both searching and find/replace
set smartcase

set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/vimfiler.vim'
Bundle 'Shougo/unite.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tmhedberg/matchit'
Bundle 'lambacck/python_matchit'
" Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
" Bundle 'jiangmiao/auto-pairs'
Bundle 'rking/ag.vim'
Bundle 'majutsushi/tagbar'
Bundle 'airblade/vim-gitgutter'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'qstrahl/vim-matchmaker'
Bundle 'haya14busa/incsearch.vim'
Bundle 'tpope/vim-commentary'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'Chiel92/vim-autoformat'
Bundle 'marijnh/tern_for_vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'godlygeek/csapprox'
Bundle 'flazz/vim-colorschemes'
Bundle 'gregsexton/gitv'
Bundle 'vim-scripts/MultipleSearch'
Bundle 'int3/vim-extradite'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/neosnippet.vim'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'terryma/vim-expand-region'
Bundle 'tpope/vim-sleuth'
Bundle 'jordwalke/VimCompleteLikeAModernEditor'
Bundle 'matthewsimo/angular-vim-snippets'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'vim-scripts/SyntaxComplete'
Bundle 'pangloss/vim-javascript'
Bundle 'freitass/todo.txt-vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'jeetsukumaran/vim-indentwise'
Bundle 'kshenoy/vim-signature'
Bundle 'Valloric/YouCompleteMe'
Bundle 'ervandew/supertab'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'dyng/ctrlsf.vim'
call vundle#end()
filetype plugin indent on    " required

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"            

" Use Ranger file browser as explorer
function! RangerChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1

let g:ctrlp_cmd = 'CtrlPMRU'
" noremap <c-l> :CtrlPFunky<CR>
noremap <leader>p :CtrlPFunky<Cr>
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" Using ag is faster, BUT wildignore doesn't work
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' 
" let g:ctrlp_use_caching = 0

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rst|pyc)$'
set wildignore+=*/env/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
let g:ctrlp_working_path_mode = 'a'
" nnoremap <c-g> :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

set foldmethod=indent
set foldnestmax=8
"set foldlevelstart=20
set foldlevelstart=99

autocmd Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
autocmd Syntax python setlocal foldmethod=indent
autocmd Syntax python normal zR
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

set foldtext=getline(v:foldstart)
set fillchars=fold:\ "(there's a space after that \)


" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Highlight word under cursor in a color
nmap <leader>h "hyiw:Search <c-r>h<CR>
vmap <leader>h "hy:Search <c-r>h<CR>
nmap <leader><leader>h :SearchReset<CR>
"let g:MultipleSearchMaxColors=10

" noremap - :VimFiler<CR>
noremap - :VimFilerBuffer  -simple -winwidth=35 -toggle -quit<cr>
noremap _ :update<CR>:cd %:p:h<CR>:VimFiler -project -find -toggle -auto-cd<CR>

noremap <F1> :!%:p<CR>
" noremap <F2> :SignatureListMarka<CR>
" nnoremap <F2> "zyiwyypiprint "A"?def<CR>y$<c-o>Oprint "pA"iprint oprint "ZZZZ <ESC>:execute "normal! a" . ( line(".") + 1 )<CR>a "zpa: '" + str(<ESC>"zp<ESC>A) + "'"<ESC>oraw_input()<ESC>
"             Copy     Print crnt    Copy def      Paste def         Print debug line
" nnoremap <F2> "zyiwyypiprint "  A"?def<CR>y$<c-o>Oprint 'pA'joprint "  ZZZZ <ESC>:execute "normal! a" . ( line(".") + 1 )<CR>a "zpa: '" + str(<ESC>"zp<ESC>A) + "'"<ESC>oraw_input()<ESC>
vnoremap <F2> "vyoprint "      "vpa: "a + str("vpa)
nnoremap <F2> "wyiw ^"ly$ ?  def<CR> ^"dy$   ?^class<CR> ^"cy$   o# ZZZZ --------------  oprint ""cpa"  oprint ""dpa"    oprint "  :execute "normal! i" . ( line(".") + 1 )<cr>a  "lpa"      oprint "      "wpa: " + str("wpa)    oraw_input()
" noremap <F3> :Ag 
noremap <F3> :CtrlSF 
noremap <leader><F3> :Ag<CR>
noremap <F4> :call RangerChooser()<CR>
inoremap <F5> <ESC>:wa<CR>:!clear<CR>:!%:p<CR>
nnoremap <F5> :wa<CR>:!clear<CR>:!%:p<CR>
vnoremap <F5> :w !bash<BAR>less<CR>
noremap <F6> :!tig %<CR>
noremap <F7> :SyntasticCheck<CR>:Errors<CR>
noremap <Leader><F7> :SyntasticReset<CR>
noremap <silent> <F8> :!clear;python %<CR>
noremap <F10> :!pudb %<CR>
" noremap <Leader>- <c-w>_<c-w><BAR>
" noremap <Leader>= <c-w>=
noremap z <c-w>_<c-w><BAR>
noremap <Leader>z <c-w>=

" This messes up <c-i> if you bind <TAB>
" nnoremap <TAB> <c-w><c-w>
" nnoremap <TAB> <c-^>

let mapleader = ","

map <leader>/ :nohlsearch<CR>
map <leader>c :q<CR>
map <leader>d :sp<CR>:YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>e :sp ~/.vimrc<CR>
map <leader><leader>j :join<CR>
map <leader>p :set paste!<CR>
map <leader>q :q<CR>
map <leader>r "ryiw:%s/<c-r>r
map <leader><leader>r :sp ~/.vimrc<CR>
map <leader>s :sp<CR>
map <leader>t :tabnew<CR>
map <leader>v :vsp<CR>
map <leader>w :w<CR>
map <leader>` :marks<CR>
map <leader>' :marks<CR>
map <leader><leader>cd :cd %:p:h<CR>

map <leader>ge :Gedit<CR>
map <leader>gs :Gstatus<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gR :Gread<CR>
map <leader>gw :Gwrite<CR>
map <leader>gl :Glog<BAR>:bot copen<CR>
map <leader>gL :Extradite<CR>

" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c
" nmap <c-[> '[
" nmap <c-]> ']
" nmap <c-j> ]'
" nmap <c-k> ['
" noremap <c-h> g;
noremap H g;
" noremap <c-l> g,
noremap L g,
noremap <leader>l g;999g,
"  And get or put the diff
" C-M THIS MESSES UP COPEN LIST PRESSING ENTER
"noremap <c-m> g;
"noremap <c-n> g,
noremap <c-n> g;
noremap <leader>n 999g,
noremap <c-f> :cnext<CR>
noremap <c-b> :cprev<CR>


"nnoremap <buffer> K :<C-u>execute "!pydoc " . expand("<cword>")<CR>

let g:vimfiler_as_default_explorer = 1

" map H <Plug>(vimfiler_switch_to_history_directory)
" map H ^
" map L g_
map Y y$

" Paste text from other places safely
set pastetoggle=<F9>

"inoremap <ESC> <Nop>


" Comment out a line of code
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary

vmap <Leader>s <Plug>Vsurround
vmap <Leader>S <Plug>VSurround

" Center screen when going through search results
nnoremap n nzz
nnoremap N Nzz

" Keep location of file when reopening
autocmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\       exe 'normal! g`"zvzz' |
\   endif

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:syntastic_javascript_jshint_args = '--config /home/shawn/.jshintrc'

let g:ackprg = "ack-grep"

" map <c-l> :cnext<CR>
" map <c-h> :cprev<CR>

"map <c-w> :NEXTCOLOR<CR>




" Auto indent wasn't working without this on bottom
filetype indent on
set ai
set si

" Prevent browsing in Fugitive from creating a trail of temp file buffers
autocmd BufReadPost fugitive://* 
  \ set bufhidden=delete




"map <F1> :colo sift<CR>
"map <F2> :highlight<CR>
"map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
"map <F4> <c-a>:w <BAR> :colo sift<CR>
"map <F5> <c-x>:w <BAR> :colo sift<CR>

"let g:hardtime_default_on = 1

"xmap s S






" let g:UltiSnipsSnippetDirectories += '/home/shawn/.vim/bundle/angular-vim-snippets/UltiSnips/'


let g:used_javascript_libs = 'jquery, underscore, backbone, angularjs'

" nnoremap <S-J> }
" noremap <S-K> {

" Jump to bookmark
" nnoremap J ]'
" nnoremap K ['
" noremap K {
" noremap J }

" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

map \ :YcmCompleter GoToDefinitionElseDeclaration<CR><CR>
map <BAR> "hyiw?\(class\s\\|var\\|def\s\).*<c-r>h<CR>:nohlsearch<CR>
" nnoremap <c-g> :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" vim-indentwise
" map K [-
" map J <c-o>

" noremap <Space> za
" Mark next, based on Vim-Signature
map <Space> m.

map Q :cprev<CR>
map <c-q> :cnext<CR>

let g:ag_highlight=1

" nnoremap s "ryiw?var\s<c-r><c-w>\\|\(class\s\\|def\s\\|Bundle\)[^=]*<c-r><c-w>\\|\<c-r><c-w>.*\(class\s\\|def\s\\|Bundle\)\\|<c-r><c-w>\s=\\|function.*(.*<c-r><c-w>.*)<CR>0/<c-r>r<CR>:nohlsearch<CR>
" noremap s "ryiw?<c-r><c-w>\s=<CR>0/<c-r>r<CR>:nohlsearch<CR>

" Don't automatically do line breaks on long lines
set formatoptions-=t

" nmap v <nop>
" nmap V <nop>
" nmap h <nop>
" nmap j <nop>
" nmap k <nop>
" nmap l <nop>
" nmap j 5<DOWN>
" nmap k 5<UP>

" nmap J }<down>
" vmap J <down>}<up>
" nmap K <up>{<down>
" vmap K <up>{<down>
map J /^    \w<CR>:nohlsearch<CR>
map K ?^    \w<CR>:nohlsearch<CR>

" nmap J <down>}?[^ ]<CR>:nohlsearch<CR>
" nmap K {?[^ ]<CR>:nohlsearch<CR>
" nmap J ]'
" nmap K ['

" map s <Plug>(easymotion-prefix)
" map s <Plug>(easymotion-s)
" map S <Plug>(easymotion-F)
" map s <Plug>(easymotion-f)
" map S <Plug>(Sneak_s)

vmap <leader><leader>n :norm 
nmap <leader><leader>g :%g/
