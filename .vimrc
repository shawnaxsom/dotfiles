"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE SURE TO DO THIS IN YOUR FISH SHELL CONFIG: set -x TERM xterm-256color
" MAKE SURE TO USE Source Code Pro FONT IN YOUR TERMINAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-reload VIMRC
autocmd! bufwritepost .vimrc source %


set noswapfile
set nowrap
set noautochdir "Some plugins don't work with this enabled, like vimfiler or vimshell
syntax on
set background=dark
colo sift
"CSApprox " Show GVim color schemes in 256 bit terminals

set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 11
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set mouse=a
set virtualedit=all "allow cursor to stay in same column while scrolling
set clipboard=unnamedplus " allow copy/paste using system clipboard (otherwise have to use "+)
set tabstop=2 shiftwidth=2 expandtab autoindent smarttab smartindent
set backspace=indent,eol,start
set scrolloff=18 "Keep cursor centered
set cindent
set shell=bash
set more " Use MORE as pager

" Relative line numbers
set number
"if exists('+rnu') | set relativenumber | endif

" Ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

set laststatus=2
set statusline=%-20t
set statusline+=(%f)
set statusline+=%=        " Switch to the right side
" set statusline+=Current:\ %-4l\ Total:\ %-4L
" set statusline+=%y // file type
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args = "--ignore=E501 --max-complexity 10"

set incsearch
set ignorecase
set smartcase

"nmap \e :NERDTreeToggle<CR>
"let NERDTreeIgnore = ['\.pyc$']

set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","

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
Bundle 'Lokaltog/vim-easymotion'
Bundle 'fs111/pydoc.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'jiangmiao/auto-pairs'
Bundle 'klen/python-mode'
Bundle 'mileszs/ack.vim'
Bundle 'majutsushi/tagbar'
Bundle 'airblade/vim-gitgutter'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'qstrahl/vim-matchmaker'
Bundle 'vim-scripts/taglist.vim'
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
Bundle 'Shougo/neocomplete.vim'
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
call vundle#end()
filetype plugin indent on    " required
               

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
        " Nothing to open.
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
" fun! RangerChooser()
"   exec "silent !ranger --choosefile=/tmp/chosenfile" . expand("%:p:h")
"   if filereadable('/tmp/chosenfile')
"     exec 'edit ' . system('cat /tmp/chosenfile')
"     call system('rm /tmp/chosenfile')
"   endif
"   redraw!
" endfun
command! -bar RangerChooser call RangeChooser()

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1

" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
" let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
" let g:ycm_complete_in_comments = 1 " Completion in comments
" let g:ycm_complete_in_strings = 1 " Completion in string

" let g:clang_snippets_engine='clang_complete'
" nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ctrlp_cmd = 'CtrlPMRU'
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|rst|pyc)$'
set wildignore+=*/node_modules/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>p :CtrlPFunky<Cr>
nnoremap <c-g> :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

set foldmethod=indent
set foldnestmax=8
set foldlevelstart=20

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

nnoremap <S-J> }
nnoremap <S-K> {

" noremap - :VimFiler<CR>
noremap - :VimFilerBuffer  -simple -winwidth=35 -toggle -quit<cr>
noremap _ :update<CR>:cd %:p:h<CR>:VimFiler -project -find -toggle -auto-cd<CR>

noremap <F1> :!tig %<CR>
noremap <F2> :call RangerChooser()<CR>
noremap <F3> "hyiw:Ack <c-r>h
noremap <silent> <F4> :Tlist<CR>
vnoremap <silent> <F5> :w !sh<CR>
noremap <F5> :!%:p<CR>
noremap <F7> :SyntasticCheck<CR>:Errors<CR>
noremap <Leader><F7> :SyntasticReset<CR>
noremap <silent> <F8> :!clear;python %<CR>
noremap <F10> :!pudb %<CR>
" noremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>

map <leader>c :q<CR>
map <leader>d :tab sp<CR>
map <leader>e :sp ~/.vimrc<CR>
map <leader>j <S-J>
map <leader>q :q<CR>
map <leader>s :sp<CR>
map <leader>v :vsp<CR>
map <leader>w :w<CR>
map <leader>x :tabn<CR>
map <leader>z :tabp<CR>
map <leader>` :marks<CR>
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
nmap <c-j> ]c
nmap <c-k> [c
" And get or put the diff
noremap <c-m> g;
noremap <c-n> g,

nnoremap s <Plug>(easymotion-s)


"nnoremap <buffer> K :<C-u>execute "!pydoc " . expand("<cword>")<CR>

let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1

let g:vimfiler_as_default_explorer = 1

map H <Plug>(vimfiler_switch_to_history_directory)

" Paste text from other places safely
set pastetoggle=<F9>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'T'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0


" Comment out a line of code
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary

" Center screen when going through search results
nnoremap n nzz
nnoremap N Nzz

" Escape by typing jj
imap jj <Esc>

" Keep location of file when reopening
autocmd BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\       exe 'normal! g`"zvzz' |
\   endif

map <leader>m :marks<CR>

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:syntastic_javascript_jshint_args = '--config /home/shawn/.jshintrc'

let g:ackprg = "ack-grep"

map <c-l> :cnext<CR>
map <c-h> :cprev<CR>

"map <c-w> :NEXTCOLOR<CR>




" Auto indent wasn't working without this on bottom
filetype indent on
set ai
set si

" Prevent browsing in Fugitive from creating a trail of temp file buffers
autocmd BufReadPost fugitive://* 
  \ set bufhidden=delete



set diffopt+=vertical

"map <F1> :colo sift<CR>
"map <F2> :highlight<CR>
" map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
"map <F4> <c-a>:w <BAR> :colo sift<CR>
"map <F5> <c-x>:w <BAR> :colo sift<CR>

"let g:hardtime_default_on = 1

xmap s S





"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#max_list = 10

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
" set completeopt+=longest
" let g:neocomplete#enable_auto_select = 1
" let g:neocomplete#disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Increase the selected region, defaults are plus/minus
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible ? "\<C-n>" : "\<TAB>"

" let g:UltiSnipsSnippetDirectories += '/home/shawn/.vim/bundle/angular-vim-snippets/UltiSnips/'


let g:used_javascript_libs = 'jquery, underscore, backbone, angularjs'

