nnoremap <leader>jt :! jsctags -o tags src<CR>

" {{{ Plugins
call plug#begin('~/.vim/bundle')
Plug 'mxw/vim-jsx'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/matchit'
Plug 'lambacck/python_matchit'
Plug 'tpope/vim-fugitive'
Plug 'Chun-Yang/vim-action-ag'
Plug 'airblade/vim-gitgutter'
Plug 'jelera/vim-javascript-syntax'
Plug 'qstrahl/vim-matchmaker'
Plug 'haya14busa/incsearch.vim'
Plug 'tpope/vim-commentary'
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'tacahiroy/ctrlp-funky'
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
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/gv.vim'
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
Plug 'rhysd/clever-f.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'wellle/targets.vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-vinegar'
Plug 'mtth/scratch.vim'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-eunuch'
Plug 'sjl/gundo.vim'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'rizzatti/dash.vim'
Plug 'moll/vim-node'
Plug 'othree/html5.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'  }
Plug 'sbdchd/neoformat'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/jspc.vim'
Plug 'w0rp/ale'
Plug 'jacoborus/tender.vim'
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

let g:scratch_autohide = 1
let g:scratch_persistence_file = '~/.scratch'
let g:scratch_no_mappings = 1

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
augroup fmt
  autocmd!
  autocmd BufWritePre  *.js Neoformat! javascript prettier
augroup END
" }}}

" {{{ YouCompleteMe

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
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_current_file = 0
let g:ctrlp_match_window = 'bottom,order:btt'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_default_input = 0
let g:ctrlp_types = ['fil', 'buf', 'mru']
let g:ctrlp_mruf_exclude = '.*/.vimrc\|/temp/.*' " MacOSX/Linux
let g:ctrlp_mruf_relative = 1

let g:ctrlp_extensions = ['line', 'changes', 'bookmarkdir']
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

" }}}

" {{{ Options
set noswapfile
set autoread
set nowrap
" set showbreak=...>
set breakat=\ ^I
set noautochdir "Some plugins don't work with this enabled, like vimfiler or vimshell
set nolist

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
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set incsearch
set hlsearch
set noignorecase              " affects both searching and find/replace
set smartcase

set foldmethod=indent
set foldnestmax=8
set foldlevelstart=2


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

set foldnestmax=3
set foldmethod=indent

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

" }}}

" {{{ Languages

" {{{ Python
let g:pymode_options_max_line_length=120
let python_highlight_all=1
autocmd! Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
autocmd! Syntax python setlocal foldmethod=indent
autocmd! Syntax python normal zR
" }}}

" {{{ Javascript
" nmap gd :TernDef<CR>
autocmd! FileType javascript,javascript.jsx nmap gd :TernDef<CR>
" map <leader>rn :!node %:p<CR>
autocmd! FileType javascript,javascript.jsx nmap <leader>r :!node %:p<CR>
" }}}

" {{{ Other Languages
" autocmd! Syntax c,cpp,xml,html,xhtml setlocal foldmethod=syntax
" autocmd! Syntax c,cpp,xml,html,xhtml,perl normal zR
autocmd! Syntax java map <F1> :!javac %:p && java HelloWorld<CR>
" autocmd! Syntax javascript map <F1> :!node %:p<CR>
autocmd! Syntax ruby map <F1> :!./bin/rails server<CR>

" Vue.js .vue file set filetype on load
autocmd! BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }}}

" }}}

" {{{ Mappings

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

let mapleader = "\<Space>"
noremap - :e %:p:h<CR>
" noremap _ :RangerEdit<CR>
" noremap - :RangerEdit<CR>

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

nmap = <c-w>=

map <leader>c :q<CR>
map <leader>d :sp<CR>:YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>p :set paste!<CR>
map <leader>l :set list!<CR>
map <leader>q :q<CR>
" map <leader>q :bd<CR>
" map <leader>r :!py.test %:p<CR>
map <leader>s :sp<CR>
map <leader>u :GundoToggle<CR>
map <leader>v :vsp<CR>
map <leader>w :w<CR>
map <leader>x :bd<CR>
map <leader>/ "hyiw:Ag <c-r>h<CR>:nohlsearch<CR>
map <leader><leader>j :join<CR>
map <leader><leader>s :UltiSnipsEdit<CR>
map <leader><leader>w :ToggleWorkspace<CR>
map <leader><leader>v :sp ~/.vimrc<CR>
map <leader><leader>i :PlugInstall<CR>
map <leader><leader>u :PlugClean!<CR>

" Diff put to grab changes using comma
" noremap , :diffput<CR>

map <leader>gC :Gcommit<CR>i
map <leader>gP :Gpush<CR>
map <leader>ge :Gedit<CR>
map <leader>gs :Gstatus<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gR :Gread<CR>
map <leader>gw :Gwrite<CR>
map <leader>gl :GV!<CR>  " gv.vim
map <leader>gL :Glog<BAR>:bot copen<CR>

noremap <c-f> :cnext<CR>
noremap <c-b> :cprev<CR>

" Comment out a line of code
nmap   <Plug>CommentaryLine
vmap   <Plug>Commentary

" Center screen when going through search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

map \ :YcmCompleter GoToDefinitionElseDeclaration<CR><CR>

map Q :cprev<CR>
map <c-q> :cnext<CR>

let g:ag_highlight=1

" Don't automatically do line breaks on long lines
" set formatoptions-=t

" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

" Go to next / previous change (GitGutter)
nmap <leader>j ]c
nmap <leader>k [c

map J }
map K {
map H [{
map L ]}

noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2, 35, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2, 35, 1)<CR>



vmap <leader><leader>n :norm
nmap <leader><leader>g :%g/

nmap s <Plug>(easymotion-bd-w)
" map S <Plug>(easymotion-b)
" map s <Plug>(easymotion-w)
" nmap s <Plug>(easymotion-overwin-f2)

" map s  <Plug>(incsearch-forward)
" map S  <Plug>(incsearch-backward)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l

map ! :!

imap <c-z> <c-y>,

map <leader>0 :set foldlevel=0<CR>
map <leader>1 :set foldlevel=1<CR>
map <leader>2 :set foldlevel=2<CR>
map <leader>3 :set foldlevel=3<CR>
map <leader>4 :set foldlevel=4<CR>
map <leader>5 :set foldlevel=5<CR>
map <leader>6 :set foldlevel=6<CR>
map <leader>7 :set foldlevel=7<CR>
map <leader>8 :set foldlevel=8<CR>
map <leader>9 :set foldlevel=999<CR>

map n nzo
map p pzo

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" repeat.vim
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

noremap gs :Scratch<CR>
nnoremap gs :Scratch<CR>
map gh !open https://www.npmjs.com/package/

" Emmet expand html
imap <c-e> <c-y>,

nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

nmap gr "hyiw:GrepperAg <c-r>h<CR>
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

" Keep location of file when reopening
autocmd! BufReadPost *
\   if line("'\"") > 0 && line("'\"") <= line("$") |
\       exe 'normal! g`"zvzz' |
\   endif

" Prevent browsing in Fugitive from creating a trail of temp file buffers
autocmd! BufReadPost fugitive://*
  \ set bufhidden=delete

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
colorscheme tender
" }}} Colorscheme

autocmd! bufwritepost .vimrc source % | AirlineRefresh | setlocal foldmethod=marker
autocmd! BufRead,BufNewFile .vimrc setlocal foldmethod=marker
