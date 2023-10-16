" { Vim-Plug
" Ins Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }

call plug#begin('~/.vim/bundle')
Plug 'VundleVim/Vundle.vim'


" { Plugins
" -----------------------------------------------------------------------------------------
" 1 - Essential
" -----------------------------------------------------------------------------------------
" { coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'josa42/coc-go'
Plug 'neoclide/coc-python', { 'do': ':CocInstall coc-python' }
Plug 'neoclide/coc-tsserver', { 'do': ':CocInstall coc-tsserver' }
Plug 'neoclide/coc-git', { 'do': ':CocInstall coc-git' }
Plug 'neoclide/coc-eslint', { 'do': ':CocInstall coc-eslint' }
Plug 'neoclide/coc-lists', { 'do': ':CocInstall coc-lists' }
Plug 'neoclide/coc-css', { 'do': ':CocInstall coc-css' }
" Plug 'neoclide/coc-ccls', { 'do': ':CocInstall coc-ccls' }
Plug 'neoclide/coc-json', { 'do': ':CocInstall coc-json' }
Plug 'neoclide/coc-yaml', { 'do': ':CocInstall coc-yaml' }
Plug 'neoclide/coc-pairs', { 'do': ':CocInstall coc-pairs' }
" Automatically move closing curly brackets to a new line after pressing enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
Plug 'fannheyward/coc-react-refactor', { 'do': ':CocInstall coc-react-refactor' }
Plug 'fannheyward/coc-marketplace', { 'do': ':CocInstall coc-marketplace' }
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
nmap K <Plug>(coc-git-prevchunk)
nmap J <Plug>(coc-git-nextchunk)
" https://octetz.com/docs/2019/2019-04-24-vim-as-a-go-ide/
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>
" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
" Make sure coc.nvim completion popup doesn't block the view of the cursor
" https://github.com/neoclide/coc.nvim/issues/2233
" autocmd User CocOpenFloat call nvim_win_set_width(g:coc_last_float_win, 9999)
" autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'editor', 'row': 0, 'col': 0})
autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'cursor', 'row': 2, 'col': -25})
" autocmd User CocOpenFloat call nvim_win_set_width(g:coc_last_float_win, 100)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" }
" { vim-go
Plug 'fatih/vim-go'
let g:go_list_type = "quickfix"
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" au FileType go nmap <Leader>dr <Plug>(go-referrers)
au FileType go nmap <Leader>r <Plug>(go-referrers)
let g:go_doc_keywordprg_enabled = 0
" }
" " { vim-db
" " Highlight a query and run in mongo
" Plug 'tpope/vim-db'
" nmap ,q vip:DB mongodb:///localhost:27017/wellexpert2<CR>
" xmap ,q :DB mongodb:///localhost:27017/wellexpert2<CR>
" " }
" { vim-quickly
" Plug 'axs221/vim-quickly'
" let g:quickly_enable_default_key_mappings = 1
" let g:quickly_always_jump_to_first_result = 1
" let g:quickly_open_quickfix_window = 0
" }
" { vim-byline
" Plug 'axs221/vim-byline'
" }
" " { Dirvish
" NOTE: Dirvish doesn't work well with Vim-Rooter or autochdir, changing to
" vim-vinegar for now
" Plug 'justinmk/vim-dirvish'  " File manager
" " noremap - :Dirvish %<CR>:cd %:p:h<CR>
" " noremap - :Dirvish %:p:h<CR>:cd %:p:h<CR>
" " noremap <leader>- :Dirvish .<CR>:cd %:p:h<CR>
" noremap - :Dirvish %<CR>
" noremap - :Dirvish %:p:h<CR>
" noremap <leader>- :Dirvish .<CR>
" let g:dirvish_mode = ':sort ,^.*[\/],'
" let g:dirvish_relative_paths=1
" function! Relpath(filename)
"         let cwd = getcwd()
"         let s = substitute(a:filename, l:cwd . "/" , "", "")
"         return s
" endfunction
" function! InsertBookmarks()
"   " execute "norm gg:read ~/dotfiles/nvim/bookmarks"
"   execute "norm mZ"
"   execute "norm ggI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"   execute "norm I" . substitute(Relpath(expand("%:p")), '/', ' > ', 'g') . ""
"   " execute "norm I> " . substitute(substitute(fnamemodify(expand("%"), ":~:."), '/', '', ''), '/', ' > ', 'g') . ""
"   execute "norm I~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"   " execute "norm G:read ~/dotfiles/nvim/bookmarks\<cr>"
"   call feedkeys("")
"   " execute "norm 2\<c-o>0"
"   execute "norm 1\<c-o>0"
" endfunction
" function! AddExtension (path, defaultExtension)
"   if a:path =~ '\.[a-zA-Z0-9]\+$'
"     return a:path
"   endif
"   return a:path . a:defaultExtension
" endfunction
" augroup dirvish_mappings
"   autocmd!
"   autocmd FileType dirvish cd %:p:h
"   autocmd FileType dirvish nnoremap <buffer> <leader>r :Shdo! mv {} {}<CR>
"   autocmd FileType dirvish nnoremap <buffer> <leader>c :Shdo! cp -R {} {}:h<CR>
"   autocmd FileType dirvish nnoremap <buffer> <leader>d :Shdo! rm -rf {} {}:h<CR>
"   autocmd FileType dirvish nnoremap <silent><buffer> e :execute "e " . AddExtension(input("Edit: File Name? ", expand('%:p')), ".js")<BAR>normal R<CR>
"   autocmd FileType dirvish nnoremap <buffer> cp :call feedkeys(':!cp ' . expand('<cWORD>') . ' %')<CR>
"   autocmd FileType dirvish nnoremap <silent><buffer> cp :execute ":!cp " . expand('<cWORD>') . " " . AddExtension(input("Copy: File Name? ", expand('%:p')), ".js")<BAR>normal R<CR>
"   autocmd FileType dirvish nnoremap <buffer> mk :execute "Mkdir " . input("Mkdir: Folder Name? ", expand('%:p'))<BAR>normal R<CR>
"   autocmd FileType dirvish nnoremap <buffer> mv :call feedkeys(':!mv ' . expand('<cWORD>') . ' ' . expand('<cWORD>'))<CR>
"   autocmd FileType dirvish nnoremap <silent><buffer><expr> dd (confirm("Are you sure?", "&Yes\n&No") == 1 ? ":!rm -rf " . expand('<cWORD>') . "<CR>:normal R<CR>" : "")
"   autocmd FileType dirvish nnoremap <buffer> ! :Shdo! {}<LEFT><LEFT><LEFT><SPACE>
"   autocmd FileType dirvish nnoremap <buffer> b :norm gg<CR>:0read ~/dotfiles/nvim/bookmarks<CR>
"   autocmd FileType dirvish nnoremap <buffer> ~ :e $HOME<CR>
"   autocmd FileType dirvish nnoremap <buffer> ` :e $HOME<CR>
"   autocmd FileType dirvish nnoremap <buffer> _ :e .<CR>
"   " Enable :Gstatus and friends.
"   " autocmd FileType dirvish call fugitive#detect(@%)
"   " autocmd FileType dirvish call InsertBookmarks()
" augroup END
" " }
" { tpope/vim-vinegar
Plug 'tpope/vim-vinegar'
" map <leader>- :e `=getcwd()`<CR>
" nmap - <Plug>VinegarUp<BAR>:pwd<CR>
" nmap - :e ..<CR>
" function! g:ChangeDirectory()
"   " exec "norm \<Plug>(VinegarUp)"
"   e ..

"   " echo (expand("%:p") != "" ? expand("%:p") : expand("%:p:h"))
" endfunction
" augroup vinegarcustom
"   autocmd!
"   " autocmd FileType netrw nmap - <Plug>VinegarUp
"   " autocmd FileType netrw echo expand("%:p")
"   " autocmd FileType netrw call g:EchoPath()
"   " autocmd FileType netrw echo b:netrw_curdir
"   autocmd FileType netrw nmap <buffer> - call g:ChangeDirectory()
"   " autocmd FileType netrw nmap <buffer> - <Plug>VinegarUp<BAR>:echo (expand("%:p") != "" ? expand("%:p") : expand("%:p:h"))<CR>
"   " autocmd FileType netrw nmap <buffer> - <Plug>VinegarUp<BAR>:echo expand("%:p:h")<CR>
"   " autocmd FileType netrw nmap <buffer> - <Plug>VinegarUp<BAR>:echo getcwd()<CR>
"   " autocmd FileType netrw nmap <buffer> <CR> <Plug>NetrwLocalBrowseCheck<BAR>:echo (expand("%:p") != "" ? expand("%:p") : expand("%:p:h"))<CR>
"   autocmd FileType netrw nmap <buffer> <CR> <Plug>NetrwLocalBrowseCheck<BAR>:echo expand("%:p:h")<CR>
"   " autocmd FileType netrw nmap <buffer> - <Plug>VinegarUp<BAR>:call g:EchoPath()<CR>
"   " autocmd FileType netrw nmap <buffer> - <Plug>VinegarUp
"   " autocmd FileType netrw nmap <buffer> <CR> <Plug>NetrwLocalBrowseCheck<BAR>:echo (expand("%:p") != "" ? expand("%:p") : expand("%:p:h"))<CR>
"   " autocmd FileType netrw echo b:netrw_curdir
"   " autocmd DirChanged netrw echo b:netrw_curdir
"   " autocmd FileType netrw pwd
"   " autocmd BufEnter netrw pwd
"   " autocmd DirChanged netrw echo b:netrw_curdir
"   " autocmd FileType netrw echo getcwd()
" augroup END
" }
" { nginx
Plug 'chr4/nginx.vim'
" }
" { CtrlP
 " Plug 'ctrlpvim/ctrlp.vim'
" nnoremap <leader>p :CtrlP<CR>
 " " nnoremap <silent> <c-f> :CtrlPLine<CR>

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
 " let g:ctrlp_cmd = 'CtrlPMRUFiles'
 " let g:ctrlp_use_caching = 0
 " let g:ctrlp_by_filename = 0
 " let g:ctrlp_regexp = 0
 " let g:ctrlp_match_window_reversed = 0
 " let g:ctrlp_mruf_relative = 1
 " let g:ctrlp_match_current_file = 0
 " let g:ctrlp_match_window = 'bottom,order:btt'
 " let g:ctrlp_switch_buffer = 'e'
 " let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
 " " let g:ctrlp_working_path_mode = 'ra'
 " let g:ctrlp_working_path_mode = 'a'
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
" {
Plug 'junegunn/gv.vim'
map <leader>gc :Gcommit<CR>i
map <leader>gp :Gpull<CR>
map <leader>gP :Gpush<CR>
map <leader>ge :Gedit<CR>
map <leader>gs :Gstatus<CR>
map <leader>gs :Gstatus<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gdiff<CR>
map <leader>gR :Gread<CR>
map <leader>gw :Gwrite<CR>
map <leader>gh :.Gbrowse<CR>
map <leader>gl :Extradite<CR>
map <leader>gL :Glog<BAR>:bot copen<CR>
map <leader>gv :GV<CR>
map <leader>gV :GV!<CR>
map <leader><leader>gv :GV!<CR>
" }
" }
" { Vimux / Dispatch
" Plug 'tpope/vim-dispatch'
" Plug 'benmills/vimux'  "  Run external commands in a small split Tmux pane
" let g:VimuxHeight = "20"
" let g:VimuxPromptString = "Vimux>  $ "
" map ,v :call VimuxPromptCommand("npm start")<CR>
" " Dispatch is better for single tasks, shows quickfix results afterwards
" map ,d :Dispatch<SPACE>
" function! VimuxRunFromClipboard()
"   let clipboardText = @+
"   let clipboardText = substitute(clipboardText, "\n", "", "g")
"   let clipboardText = substitute(clipboardText, "\r", "", "g")
"   let clipboardText = substitute(clipboardText, "^@", "", "g")
"   let clipboardText = substitute(clipboardText, "http://", "", "")
"   let command = ':!' . clipboardText
"   execute command
" endfunction
" vmap ,r y:call VimuxRunFromClipboard()<CR>
" map ,i :call VimuxInspectRunner()<CR>
" map ,c :call VimuxInterruptRunner()<CR>
" map ,f :Dispatch npm test -- --tests %
" map ,b :Dispatch npm run build<CR>
" map ,z :VimuxZoomRunner<CR>
" map ,a :Dispatch npm test<CR>
" map ,t :Dispatch npm test -- --tests %<CR>
" augroup vimux
"   autocmd!
"   autocmd BufEnter */api/* map <buffer> ,r :sp term://npm run build; NODE_ENV=qa npm start")<CR>
"   autocmd BufEnter */api/* map <buffer> ,q :sp term://npm run build; NODE_ENV=qa npm start")<CR>
"   autocmd BufEnter */api/* map <buffer> ,t :Dispatch npm test -- --tests %<CR>
"   autocmd BufEnter */optimization/*,*/recommendations/*,*/ambyint-platform-admin/*,*/iot/* map <buffer> ,t :Dispatch npm test -- --tests %<CR>
"   autocmd BufEnter */web/* map <buffer> ,t :Dispatch npm run test<CR>
"   autocmd BufEnter */utils/* map <buffer> ,t :Dispatch npm run test<CR>
" augroup END
" }
" { vim-tmux-navigator
" Ctrl + J/K/H/L to move to different Vim or Tmux panes.
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 2
" }
" { UltiSnips
"Plug 'SirVer/ultisnips'
" nmap <leader>eu :UltiSnipsEdit<CR>
let g:UltiSnipsEditSplit="vertical"
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
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" }
" { Todo.txt-vim
Plug 'freitass/todo.txt-vim'
" }
" { Deoplete
" Unlike YouCompleteMe, Deoplete allowed completion in buffer of a variable
" followed by a property in a string. "rodDimensions." showed all props of
" random variable.
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wellle/tmux-complete.vim'
" set completeopt-=preview
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#auto_complete_delay = 0
" let g:deoplete#auto_refresh_delay = 30
" let g:deoplete#enable_ignore_case = 1
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_camel_case = 1
" let g:deoplete#enable_refresh_always = 1
" let g:deoplete#buffer#require_same_filetype = 0
" let g:deoplete#file#enable_buffer_path = 0
" let g:deoplete#max_abbr_width = 0
" let g:deoplete#max_menu_width = 0
" let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" let g:deoplete#file#enable_buffer_path = 1
" let g:deoplete#omni#functions = {}
" let g:jsx_ext_required = 0
" }
" { deoplete-ternjs
" " TODO TernJS slows down Deoplete considerably
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g tern' }
" let g:deoplete#omni#functions.javascript = [
"   \ 'tern#Complete',
"   \ 'jspc#omni',
" \]
" " Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" let g:deoplete#sources#ternjs#timeout = 1
" " Whether to include the types of the completions in the result data. Default: 0
" let g:deoplete#sources#ternjs#types = 1
" " Whether to include the distance (in scopes for variables, in prototypes for
" " properties) between the completions and the origin position in the result
" " data. Default: 0
" let g:deoplete#sources#ternjs#depths = 1
" " Whether to include documentation strings (if found) in the result data.
" " Default: 0
" let g:deoplete#sources#ternjs#docs = 1
" " When on, only completions that match the current word at the given point will
" " be returned. Turn this off to get all results, so that you can filter on the
" " client side. Default: 1
" let g:deoplete#sources#ternjs#filter = 0
" " Whether to use a case-insensitive compare between the current word and
" " potential completions. Default 0
" let g:deoplete#sources#ternjs#case_insensitive = 1
" " When completing a property and no completions are found, Tern will use some
" " heuristics to try and return some properties anyway. Set this to 0 to
" " turn that off. Default: 1
" let g:deoplete#sources#ternjs#guess = 0
" " Determines whether the result set will be sorted. Default: 1
" let g:deoplete#sources#ternjs#sort = 0
" " When disabled, only the text before the given position is considered part of
" " the word. When enabled (the default), the whole variable name that the cursor
" " is on will be included. Default: 1
" let g:deoplete#sources#ternjs#expand_word_forward = 0
" " Whether to ignore the properties of Object.prototype unless they have been
" " spelled out by at least to characters. Default: 1
" let g:deoplete#sources#ternjs#omit_object_prototype = 0
" " Whether to include JavaScript keywords when completing something that is not
" " a property. Default: 0
" let g:deoplete#sources#ternjs#include_keywords = 1
" " If completions should be returned when inside a literal. Default: 1
" let g:deoplete#sources#ternjs#in_literal = 0
" "Add extra filetypes
" let g:deoplete#sources#ternjs#filetypes = [
"                 \ 'jsx',
"                 \ 'javascript.jsx',
"                 \ 'vue',
"                 \ ]
" }
" { vim-polyglot
" Collection of language plugins.
" Includes: 'pangloss/vim-javascript'
" Includes: 'mxw/vim-jsx'
" Plug 'sheerun/vim-polyglot'
" TODO: Removed polyglot for now. It was messing with Vue.js code I was working
" on. Use individual pieces from it instead.
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'
" }
" { vim-obsession
" Save buffers in session using automation over the built-in session
" management. Add vim -S Session.vim alias in your fish.config or .bashrc.
" :qa to exit Vim with all panes intact.
Plug 'tpope/vim-obsession'
function! s:CreateSessionIfNotExists() abort
  if !filereadable("Session.vim")
    Obsess
  endif
endfunction
command! CreateSessionIfNotExists call s:CreateSessionIfNotExists()
nmap <leader><leader>w :Obsess!<CR>
autocmd VimEnter * CreateSessionIfNotExists
" }
" " { Abolish
" " %S/foo/bar will replace smart-casing
" " %S/map{,s}/draw{,ings} will replace variants of the words
" " Also change word naming convention
" " crk - kabob-case
" " crs - snake_case
" " crc - camelCase
" " crm - MixedCase
" Plug 'tpope/tpope-vim-abolish'
" " nmap <leader>S yiwV:s/"/
" " vmap <leader>S :s/
" " " nmap <leader>s yiwV:S/"/
" " nmap <leader>s yiwV:S/
" " vmap <leader>s :S/
" " nmap <leader><leader>S :%s//
" " vmap <leader><leader>S y:%s/+/
" " nmap <leader><leader>s :%S//
" " vmap <leader><leader>s y:%S/+/
" " }
" { vim-rest-console
Plug 'diepm/vim-rest-console'
let g:vrc_set_default_mapping = 0
augroup vrc
  autocmd!
  autocmd FileType rest map <buffer> <enter> :call VrcQuery()<CR>
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
" { blueyed/vim-qf_resize
" Plug 'blueyed/vim-qf_resize'
" }
" " { ALE
" " :ALEFix to autogically fix any lint errors that have an obvious fix.
" " Add rules to ~/.eslintrc to ignore certain lint errors.
" Plug 'w0rp/ale'  " Async linting
" " nnoremap <leader>F :ALEFix<CR>:ALELint<CR>:ALEFirst<CR>
" nnoremap <leader>= :ALEFix<CR>:ALELint<CR>:ALEFirst<CR>
" let g:ale_list_window_size = 2
" let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
" let g:ale_javascript_eslint_use_global = 0
" let g:ale_fixers = { 'javascript': [ 'eslint' ] }
" let g:ale_linters = { 'javascript': [ 'eslint' ] }
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
" let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" let g:ale_lint_on_text_changed = 0
" let g:ale_open_list = 0
" let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 0
" let g:ale_set_highlights = 1
" let g:ale_set_signs = 1
" let g:ale_echo_cursor = 1
" com! ALECheckNow     call ale#Queue(0)
" com! ALEShowCommand  echo ale_linters#python#flake8#GetCommand(bufnr('%'))
" " }
" -----------------------------------------------------------------------------------------
" 2 - Great
" -----------------------------------------------------------------------------------------
" {
" Plug 'RRethy/vim-illuminate'
" let g:Illuminate_delay = 250
" hi illuminatedWord ctermfg=red guibg=#852040
" let g:Illuminate_highlightUnderCursor = 1
" }
" { matchmaker - Highlight word under cursor
" NOTE: Change the color in colorscheme.vimrc
Plug 'qstrahl/vim-matchmaker'
let g:matchmaker_enable_startup = 1
let g:matchmaker_matchpriority = 1
" nnoremap ,, :MatchmakerToggle<CR>
" }
" { Surround
Plug 'tpope/vim-surround'
vmap s <Plug>VSurround
vmap s <Plug>VSurround
" }
" { GitGutter
" Plug 'airblade/vim-gitgutter'
" let g:gitgutter_highlight_lines = 0
" let g:gitgutter_map_keys = 0
" set updatetime=100
" noremap ]c :GitGutterNextHunk<CR>
" noremap [c :GitGutterPrevHunk<CR>
" " noremap <leader>j :GitGutterNextHunk<CR>
" " noremap <leader>k :GitGutterPrevHunk<CR>
" noremap J :GitGutterNextHunk<CR>
" noremap K :GitGutterPrevHunk<CR>
" }
" { Grepper
" Like :grep but a smoother experience. No display of text or flickering.
" Use Ag to search using :GrepperAg, and :copen when finished
" CtrlSF is an alternative, but that doesn't allow :cnext or immediate search
" Plug 'mhinz/vim-grepper'
" nmap <leader>8 "hyiw:GrepperAg -Q <c-r>h<CR>:nohlsearch<CR>
" vmap <leader>8 "hy:GrepperAg -Q '<c-r>h'<CR>
" nmap <leader>/ "hyiw:GrepperAg ""<left>
" nmap <leader><leader>/ :GrepperAg "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" nmap <leader><leader><leader>/ :GrepperAg "" %:p:h:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" nmap <silent> ,/ :nohlsearch<CR>
" function! ToggleGrepperBuffersMode()
"   if g:grepper.buffers
"     let g:grepper.buffers = 0
"     echo "Grepper will search all files"
"   else
"     let g:grepper.buffers = 1
"     echo "Grepper will search only open buffers"
"   endif
" endfunction
" map ]gb :call ToggleGrepperBuffersMode()<CR>
" function! ToggleGrepperDirectoryMode()
"   if g:grepper.dir == 'file'
"     let g:grepper.dir = 'cwd'
"     echo "Grepper will search all files"
"   else
"     let g:grepper.dir = 'file'
"     echo "Grepper will search only current directory"
"   endif
" endfunction
" map ]gd :call ToggleGrepperDirectoryMode()<CR>
" nmap gr "hyiw:GrepperAg <c-r>h<CR>
" let g:grepper = {}
" runtime autoload/grepper.vim
" let g:grepper.jump = 0
" let g:grepper.stop = 500
" let g:grepper.highlight = 1
" let g:grepper.side = 0
" }
" { Quickfix-Reflector
" Edit files within any quickfix window, then save to dynamically update files
" Works very similar to CtrlSF, but with quickfix rather than own window
" Maybe I should just use :Doline (vim-qf) or :cdo instead
Plug 'stefandtw/quickfix-reflector.vim'
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
vmap gx  `<^i{/* `>$a */}
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
" nmap <silent> <C-S>  <Plug>GoldenViewSplit
" nmap <silent> <leader>m   <Plug>GoldenViewSwitchMain
" nmap <silent> <leader><leader>m <Plug>GoldenViewSwitchToggle
" nmap <silent> <C-N>  <Plug>GoldenViewNext
" nmap <silent> <C-P>  <Plug>GoldenViewPrevious
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
" nmap <silent> = :Neoformat prettier<CR>:ALEFix<CR>:ALELint<CR>:w<CR>:redraw<CR>:lfirst<CR>
nmap <silent> = :Neoformat prettier<CR>:ALELint<CR>:w<CR>:redraw<CR>:lfirst<CR>
augroup neoformat
  autocmd!
  autocmd BufWritePre **/web/**/*.js Neoformat prettier
  autocmd BufWritePre **/sandbox/**/*.js Neoformat prettier
  autocmd BufWritePre **/dc*/**/*.{js,ts,tsx} Neoformat prettier
  " autocmd BufWritePost **/side-projects/**/*.js Neoformat prettier | ALELint
augroup END
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_only_msg_on_error = 1
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
" Plug 'majutsushi/tagbar'
" map + :Tagbar<CR>
" let g:tagbar_autoclose = 0
" let g:tagbar_autofocus = 1
" let g:tagbar_sort = 0
" let g:tagbar_compact = 1
" let g:tagbar_case_insensitive = 1
" }
" { Gutentags
" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_ctags_exclude = ['*node_modules*', '*bower_components*', 'tmp*', 'temp*', 'package*json']
" }
" { vim-visual-star-search
" Allow you to use * and # on visually selected text
" Plug 'nelstrom/vim-visual-star-search'
" }
" { haya14busa/vim-asterisk
Plug 'haya14busa/vim-asterisk'
let g:asterisk#keeppos = 1
" map *  <Plug>(asterisk-z*)
" map #  <Plug>(asterisk-z#)
" map g* <Plug>(asterisk-gz*)
" map g# <Plug>(asterisk-gz#)
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
nnoremap c* *Ncgn
nnoremap c# #NcgN
" nnoremap <leader>. n.
" }
" { vim-lastplace
" Open files at last closed position
Plug 'farmergreg/vim-lastplace'
" }
" { djoshea/vim-autoread
" Automatically update buffers when changed externally
" Seems to work better than the built-in capabilities
Plug 'djoshea/vim-autoread'
" }
" { vim-qf
" Enhancements to the Quickfix window
" Better behavior, like closing Vim if quickfix is last window
" :Keep or :Reject to filter quickfix
" :Dolines or :Dofiles to perform :cdo/:ldo on lines or just the files
Plug 'romainl/vim-qf'
augroup vim-qf
  autocmd!
  " autocmd FileType qf nnoremap <buffer> <leader>k :Keep <CR>:copen<CR>
  " autocmd FileType qf nnoremap <buffer> <leader>r :Reject <CR>:copen<CR>
  " autocmd FileType qf nnoremap <buffer> <leader>K :Keep 
  " autocmd FileType qf nnoremap <buffer> <leader>R :Reject 
  autocmd FileType qf nnoremap <buffer> <leader>K :Keep<space>
  autocmd FileType qf nnoremap <buffer> <leader>R :Reject<space>
  autocmd FileType qf nnoremap <buffer> <leader>k :Keep <CR>:copen<CR>
  autocmd FileType qf nnoremap <buffer> <leader>r :Reject <CR>:copen<CR>
  " autocmd FileType qf vnoremap <buffer> <leader>k y:Keep "<CR>:copen<CR>
  " autocmd FileType qf vnoremap <buffer> <leader>r y:Reject "<CR>:copen<CR>
  autocmd FileType qf vnoremap <buffer> <leader>k y:Keep "<CR>:copen<CR>
  autocmd FileType qf vnoremap <buffer> <leader>r y:Reject "<CR>:copen<CR>
augroup END
" }

" -----------------------------------------------------------------------------------------
" 3 - Decent
" -----------------------------------------------------------------------------------------
" " { CtrlSF
Plug 'dyng/ctrlsf.vim'
" map <F3> :CtrlSF -R ""<LEFT>
vmap <leader><leader>8 "hy:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
nmap <leader><leader>8 "hyiw:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
nmap <leader>s :CtrlSF -R ""<LEFT>
" vmap <leader>s :CtrlSF -R "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
vmap <leader>s "hy:CtrlSF -R <c-r>h<CR>/<c-r>h<CR>
" nmap <leader><leader>/ :CtrlSF -R "" %:p:h<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
let g:ctrlsf_confirm_save = 0
" " }
" { Airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let s:prevcountcache=[[], 0]
" let g:airline#extensions#tabline#enabled = 0
" let g:airline_powerline_fonts = 1
" let g:airline_theme='jellybeans'
" let g:airline_section_a = '%{expand("%:p:t")}'
" let g:airline_section_b = '%{expand("%:p:h:t")}'
" let g:airline_section_c = '%{expand("%:p:h:h:t")}'
" let g:airline_section_x = ''
" let g:airline_section_y = ''
" let g:airline_section_z = ''
" let g:airline_section_error = ''
" let g:airline_section_warning = ''
" let g:airline_inactive_collapse = 0
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
" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'
" map /\c  <Plug>(incsearch-forward)
" map ?\c  <Plug>(incsearch-backward)
" map z/ <Plug>(incsearch-fuzzy-/)
" map z? <Plug>(incsearch-fuzzy-?)
" }
" " { Vim-Sneak
" Plug 'justinmk/vim-sneak'
" nmap s <Plug>SneakLabel_s
" nmap S <Plug>SneakLabel_S
" " map s <Plug>Sneak_s
" " map S <Plug>Sneak_S
" let g:sneak#label = 0
" " let g:sneak#s_next = 1
" " let g:sneak#target_labels = ";sftunq/SFGHLTUNRMQZ?0"
" let g:sneak#target_labels =   "sdfioweqertphjklzxcvnm"
" " }
" " { Dash.app
" Plug 'rizzatti/dash.vim'
" nmap <silent> <leader>d <Plug>DashSearch
" let g:dash_map = {
"       \ 'javascript' : [ 'javascript', 'react', 'materialui', 'rxjs', 'lodash', 'css' ]
"       \ }
" " }
" { Vim Trailing Whitespace
Plug 'bronson/vim-trailing-whitespace'
" }
" " { winresizer
Plug 'simeji/winresizer'  " <c-e> and then h/j/k/l and <enter> to resize window easier
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
noremap <leader><leader>r :RandomColorScheme<CR>:colo<CR>
" }
"
"
"
"
"
" { FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tweekmonster/fzf-filemru'
" This is the default extra key bindings
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-f': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
augroup custom_filemru
  autocmd!
  autocmd BufWinEnter * UpdateMru
augroup END
let g:fzf_history_dir = "~/fzf/history/"
let g:fzf_filemru_bufwrite = 1
" let g:fzf_filemru_git_ls = 1
let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = 'right:30%'
" Search all lines in all files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

" command! FZFMru call fzf#run({
" \  'source':  v:oldfiles,
" \  'sink':    'e',
" \  'options': '--no-sort --exact',
" \  'down':    '40%'})

" command! FZFMru call fzf#run({
" \ 'source':  reverse(s:all_files()),
" \ 'sink':    'edit',
" \ 'options': '-m -x +s --no-sort',
" \ 'down':    '40%' })
" function! s:all_files()
"   return extend(v:oldfiles,
"   \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
" endfunction

" function! fzf#vim#_recent_files()
"   return fzf#vim#_uniq(map(
"     \ filter([expand('%')], 'len(v:val)')
"     \   + filter(map(fzf#vim#_buflisted_sorted(), 'bufname(v:val)'), 'len(v:val)')
"     \   + filter(copy(v:oldfiles), "filereadable(fnamemodify(v:val, ':p'))"),
"     \ 'fnamemodify(v:val, ":~:.")'))
" endfunction

" nnoremap <c-p> :FZFMru --tiebreak=index<CR>
" nnoremap <leader>o :FZF --tiebreak=index<CR>
" nnoremap <leader>p :FZFMru --tiebreak=index<CR>
" nnoremap <leader>m :FZFMru --tiebreak=index<CR>
" nnoremap <c-p> :FZFMru --no-sort<CR>
" nnoremap <leader>o :FZF --no-sort<CR>
" nnoremap <leader>p :FZFMru --no-sort<CR>
" nnoremap <leader>m :FZFMru --no-sort<CR>
" nnoremap <leader><leader>b :Buffers<CR>

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction
function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction
command! BuffersDelete call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '-m -x +s --no-sort --exact',
\ }))
" command! BuffersNoSortExact call fzf#run(fzf#wrap({
"   \ 'source': s:list_buffers(),
"   \ 'options': '-m -x +s --no-sort --exact',
" \ }))
" command! BuffersNoSortExact call fzf#run(fzf#wrap({
"       \ 'source': s:list_buffers(),
"       \ 'options': '-m -x +s --no-sort --exact',
"       \ }))
" command! BuffersNoSortExact call fzf#vim#buffers({
"       \ 'options': '-m -x +s --no-sort --exact',
"       \ })
" command! BuffersNoSortExact call fzf#vim#buffers(<q-args>, fzf#vim#with_preview(), <bang>0)
" command! BuffersNoSortExact call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': '-m -x +s --no-sort --exact'}), <bang>0)
" call fzf#vim#gitfiles('?', {'options': '--no-preview'})
" command! BuffersNoSortExact call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': '-m -x +s --no-sort --exact'}), <bang>0)

" command! -bar -bang -nargs=? -complete=buffer BuffersNoSortExact  call fzf#vim#buffers(<q-args>, s(<bang>0, { "placeholder": "{1}" }), <bang>0)
command! BuffersNoSortExact call fzf#vim#buffers({'options': '-m -x +s --no-sort --exact'})

" command! FZFChanged call fzf#run({'source': 'git diff --name-only --oneline', 'options': '-m -x +s --no-sort --exact --no-preview', 'sink': 'edit', 'left': '40%'})
" command! FZFChanged call fzf#run({'source': 'git diff --name-only --oneline', 'options': '-m -x +s --no-sort --exact', 'sink': 'edit', 'left': '40%'})

" command! FZFLines call fzf#vim#lines({'options': '-m -x +s --no-sort --exact'})

nnoremap <c-p> :BuffersNoSortExact<CR>
nnoremap <leader>O :FZF --no-sort --exact<CR>
" nnoremap <leader>p :FilesMru --no-sort --exact<CR>
nnoremap <leader>p :BuffersNoSortExact<CR>
nnoremap <leader>m :FilesMru --no-sort --exact<CR>
nnoremap <leader>o :FilesMru --no-sort --exact<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader><leader>p :BuffersNoSortExact<CR>
" nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :BuffersDelete<CR>
" nnoremap <leader>i :FZFChanged<CR>
nnoremap <leader>i :GFiles?<CR>
" nnoremap <leader>m :History<CR>
nnoremap <leader>j :Files<CR>
nnoremap <leader><leader>l :Lines<CR>
nnoremap <leader>f :Lines func <CR>
nnoremap <leader>t :Lines func <BAR> var <BAR> const <BAR> := <BAR> type <CR>
nnoremap <leader>a :Ag func <BAR> var <BAR> const <BAR> := <BAR> type <CR>
let g:fzf_mru_relative = 1

command! FZFMostRecentlyModified call fzf#run({
\ 'source':  (s:MostRecentlyModifiedLines()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })
function! s:Wildignore(files) abort
  try
    for pattern in split(&wildignore, ',')
      call filter(a:files,
            \  "v:val.action__path !~? pattern")
    endfor
  catch /.*/
  finally
  endtry
  return a:files
endfunction
function! s:MostRecentlyModifiedLines ()
  let lines = split(system("find . -type d \\( -path ./.git -o -path ./node_modules \\) -prune -o -print0 | xargs -0 ls -t | head -n " . 50), "\n")
  " let lines = WithinPwd(lines)
  " let lines = RelativePath(lines)
  " let lines = Wildignore(lines)
  " Wildignore(lines)
  return lines
endfunction
nnoremap <leader>M :FZFMostRecentlyModified<CR>
let g:fzf_buffers_jump = 1
" :Ag - allows "?" to open preview window
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" nnoremap <c-p> :FZF<CR>
" nnoremap <leader>p :FZF<CR>
" nnoremap <c-b> :Buffers<CR>
" nnoremap <leader>b :Buffers<CR>
" }
"
"
"
"
"
" { Nova colorscheme
Plug 'zanglg/nova.vim'
" }
" " { embear/vim-localvimrc
" " Put a .lvimrc file in a project to have project specific settings
" " Example settings:
" " set path+=actions/
" " set path+=components/forms/**
" " augroup localfilemarks
" "   autocmd!
" "   autocmd BufEnter */parsers/*       normal! mP
" "   autocmd BufEnter */epics/*         normal! mE
" " augroup END
" Plug 'embear/vim-localvimrc'
" let g:localvimrc_ask = 0
" augroup localvimrc
"   autocmd!
"   autocmd BufWinEnter *      silent LocalVimRC
" augroup END
" " }

" -----------------------------------------------------------------------------------------
" 4 - Could do without
" -----------------------------------------------------------------------------------------

" -----------------------------------------------------------------------------------------
" 5 - New / Evaluating
" -----------------------------------------------------------------------------------------
" { vim-renamer
" Rename and move files and folders in batch as plain text
" :Renamer
Plug 'qpkorr/vim-renamer'
nmap <leader><leader>r :Renamer<CR>
" }
" { Vim-Rooter
" Change directory to project root if you are in a subfolder
" If you use /src as project root, this allows proper filename completion
" from /src without typing /src in your imports.
" Unfortunately, vim-dirvish doesn't work well with this on auto
Plug 'airblade/vim-rooter'
" let g:rooter_patterns = ['server.js', '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'notes']
let g:rooter_patterns = ['.git', 'Makefile', 'notes']
" let g:rooter_patterns = ['.git', 'notes']
let g:rooter_targets = '/,*'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1
" map <leader>. :cd %:p:h<CR>:Rooter<CR>:pwd<CR>
" map <leader>. :Rooter<CR>:pwd<CR>
map <leader>. :cd %:p:h<CR>
" }
" { thameera/vimv
" Alternative to vim-renamer
Plug 'thameera/vimv'
" }
" " { BufExplorer
" nmap <leader><leader>l :BufExplorer<CR>gg4j
" Plug 'jlanzarotta/bufexplorer'
" let g:bufExplorerDisableDefaultKeyMapping = 1
" let g:bufExplorerSortBy='fullpath'
" " }
" " { edkolev/tmuxline.vim
" " Use your Airline theme automatically in Tmux
" Plug 'edkolev/tmuxline.vim'
" " }
" { vim-qlist
" :help include-search
" [I will search for the word under cursor in both the current file and the
" included files.
" :Ilist - Add word under cursor to quickfix
" [I - Same thing
Plug 'romainl/vim-qlist'
" Find ES6 import syntax
set include=from[\ ]
" }
" { Valloric/MatchTagAlways
" Similar to matchmaker, but for highlighting surrounding tag
" Plug 'Valloric/MatchTagAlways'
" let g:mta_set_default_matchtag_color = 0
" let g:mta_use_matchparen_group = 0
" let g:mta_filetypes = {
"   \ 'javascript.jsx': 1,
"   \ 'html' : 1,
"   \ 'xhtml' : 1,
"   \ 'xml' : 1,
"   \ 'jinja' : 1,
"   \ }
" }
" { tpope/vim-rsi
" Use command line mappings in insert mode like:
" <c-a> and <c-e> to go to start and end of line
Plug 'tpope/vim-rsi'
" }
" { chaoren/vim-wordmotion
" Use camelCase etc for word motions like w/b/e
" Plug 'chaoren/vim-wordmotion'
" }
" { jiangmiao/auto-pairs
" NOTE: Autopairs messes with brackets that are quoted out when pressing
"       backspace, buggy. Use coc-pairs instead.
" Plug 'jiangmiao/auto-pairs'
" }
" { owickstrom/vim-colors-paramount
Plug 'owickstrom/vim-colors-paramount'
" }
" { mhartington/nvim-typescript
" Plug 'mhartington/nvim-typescript'
" }
" { TypeScript plugins
" Plug 'quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'jason0x43/vim-js-indent'
Plug 'Quramy/vim-dtsm'
Plug 'mhartington/vim-typings'
" }

" Plug 'elixir-editors/vim-elixir'
" Plug 'dsawardekar/ember.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'python-mode/python-mode'
" { jceb/vim-orgmode
Plug 'jceb/vim-orgmode'
let g:org_agenda_files=['~/org/index.org']
" }

" { Git Messenger
Plug 'rhysd/git-messenger.vim'
map <leader>k :GitMessenger<CR>
" }
" { Lens - automatically resize windows
" Plug 'camspiers/animate.vim'
" Plug 'camspiers/lens.vim'
" let g:lens#width_resize_max = 200
" let g:lens#width_resize_min = 100
" let g:lens#height_resize_min = 5
" let g:lens#height_resize_max = 30
" let g:lens#disabled_filetypes = ['fzf']
" }
" {
" { Diminactive - Dim the current active pane window
" Plug 'blueyed/vim-diminactive'
" let g:diminactive_use_syntax = 1
" Plug 'TaDaa/vimade'
" au! BufWinEnter quickfix VimadeBufDisable
" let g:vimade = {
"   \ "normalid": '',
"   \ "normalncid": '',
"   \ "basefg": '',
"   \ "basebg": '',
"   \ "fadelevel": 0.6,
"   \ "colbufsize": 15,
"   \ "rowbufsize": 15,
"   \ "checkinterval": 100,
"   \ "usecursorhold": 0,
"   \ "detecttermcolors": 0,
"   \ 'enablescroll': 1,
"   \ 'signsid': 13100,
"   \ 'signsretentionperiod': 4000,
"   \ 'fademinimap': 1,
"   \ 'fadepriority': 10,
"   \ 'groupdiff': 1,
"   \ 'groupscrollbind': 0,
"   \ 'enablefocusfading': 0,
"   \ 'enablebasegroups': 1,
"   \ 'basegroups': ['Folded', 'Search', 'SignColumn', 'LineNr', 'CursorLine', 'CursorLineNr', 'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText', 'FoldColumn', 'Whitespace']
"   \ }
" }
" " { Golden Ratio -- better automatic vim pane window resizing
" Plug 'roman/golden-ratio'
" " Don't resize Quickfix window?
" let golden_ratio_exclude_nonmodifiable = 0
" let golden_ratio_autocommand = 1
" " }
" { kana/vim-textobj-user
Plug 'kana/vim-textobj-user'
" }

" " { vim-github-dashboard
" " :GHActivity
" Plug 'junegunn/vim-github-dashboard'
" Plug 'tyru/open-browser.vim'
" " }
" { dag/vim-fish
Plug 'dag/vim-fish'
" }
" { jlanzarotta/bufexplorer
Plug 'jlanzarotta/bufexplorer'
let bufExplorerDisableDefaultKeyMapping = 1
map <leader>b   :BufExplorer<CR>
augroup bufexplorer_ft
  au!
  " Don't accidentally exit Vim if just trying to get out of bufexplorer
  autocmd FileType bufexplorer nmap <buffer> <leader>q q
  autocmd FileType bufexplorer nmap <buffer> <leader><leader>q q
augroup END

let bufExplorerShowRelativePath = 1
let bufExplorerSortBy="fullpath"
" }
" { AndrewRadev/bufferize.vim
" Make buffers out of commands like :Bufferize map
Plug 'AndrewRadev/bufferize.vim'
map <leader>? :Bufferize map<CR>
" }
" " { rhysd/clever-f.vim
" Plug 'rhysd/clever-f.vim'
" " }
" { justinmk/vim-sneak
" Plug 'justinmk/vim-sneak'
" let g:sneak#s_next = 0
" }
" " { 'easymotion/vim-easymotion'
" Plug 'easymotion/vim-easymotion'
" map <Leader> <Plug>(easymotion-prefix)
" map  s <Plug>(easymotion-bd-f)
" nmap s <Plug>(easymotion-overwin-f)
" map  S <Plug>(easymotion-bd-f)
" nmap S <Plug>(easymotion-overwin-f)
" " }
" { christoomey/vim-conflicted
" Diff conflicts merging
Plug 'christoomey/vim-conflicted'
" Also run: git config --global alias.conflicted '!vim +Conflicted'
" # Define a custom mergetool called `vim-conflicted` that runs `vim +Conflicted`
" git config --global mergetool.vim-conflicted.cmd 'vim +Conflicted'
" # Set the `vim-conflicted` mergetool to be used when `git mergetool` is executed
" git config --global merge.tool 'vim-conflicted'

" }
" " { junegunn/goyo.vim
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
" Plug 'reedes/vim-pencil'
" let g:goyo_width = 120 " (default: 80)
" let g:goyo_height = '95%' " (default: 85%)
" let g:goyo_linenr = 0 " (default: 0)
" map <leader><leader>z :Goyo<CR>:Limelight!!<CR>
" " }
" Plug 'mtth/locate.vim'
" " { vim-cpp-modern: Enhanced C and C++ syntax highlighting
" Plug 'bfrg/vim-cpp-modern'
" " }

" Plug 'preservim/nerdtree'
" " nnoremap - :NERDTreeToggle<CR>
" nnoremap - :e ..<CR>

" function! SearchNetrw(fname)
"     if ! search('\V\^' . a:fname . '\$')
"         call search('^' . substitute(a:fname, '\w\zs.*', '', '') . '.*\/\@<!$')
"     endif
" endfunction
" autocmd VimEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string(expand('%:t')) . ')'
" autocmd BufEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string(expand('%:t')) . ')'
" autocmd BufEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string("plugins.vimrc") . ')'

" " { chrisbra/NrrwRgn
" " You simply select the region, call :NR and the selected part will open in a new
" " split window while the rest of the buffer will be protected. Once you are finished,
" " simply write the narrowed window (:w) and all the changes will be moved back
" " to the original buffer.
" Plug 'chrisbra/NrrwRgn'
" " vnoremap <leader>z :NR!<CR>
" " nnoremap <silent> <leader>z :WR!<CR>
" " autocmd BufEnter * com! -nargs=* -bar -bang -count=0 -complete=dir  Explore execute "call netrw#Explore(<count>,0,0+<bang>0,<q-args>)" . ' | call SearchNetrw(' . string("plugins.vimrc") . ')'
" Plug 'jkramer/vim-narrow'
" vnoremap <leader>z :Narrow<CR>
" nnoremap <leader>z :Widen<CR>
" " }
" " { terryma/vim-multiple-cursors
" " <C-n> to make selections
" " <C-x> to skip, or <C-p> to remove and to to previous
" " c/s/I/A to edit
" Plug 'terryma/vim-multiple-cursors'
" " }
" " { terryma/vim-smooth-scroll
" " Plug 'terryma/vim-smooth-scroll'
" " noremap <silent> <c-u> :call smooth_scroll#up(&scroll/2, 10, 1)<CR>
" " noremap <silent> <c-d> :call smooth_scroll#down(&scroll/2, 10, 1)<CR>
" " Plug 'yonchu/accelerated-smooth-scroll'
" " let g:ac_smooth_scroll_du_sleep_time_msec = 20
" Plug 'yuttie/comfortable-motion.vim'
" let g:comfortable_motion_scroll_down_key = "j"
" let g:comfortable_motion_scroll_up_key = "k"
" let g:comfortable_motion_friction = 90.0
" let g:comfortable_motion_air_drag = 7.5
" let g:comfortable_motion_no_default_key_mappings = 1
" let g:comfortable_motion_impulse_multiplier = 3.5  " Feel free to increase/decrease this value.
" nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
" nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
" " Plug 'psliwka/vim-smoothie'

" " }
" " { wellle/context.vim
" " Show a contextual pane above edited window with outer indented lines, like
" " class or function name
" " This was working well at first, but it can be slow on scrolling.
" Plug 'wellle/context.vim'
" let g:context_nvim_no_redraw = 1
" let g:context_add_mappings = 0
" nnoremap <silent> <expr> <C-Y> context#util#map('<C-Y>')
" nnoremap <silent> <expr> <C-E> context#util#map('<C-E>')
" nnoremap <silent> <expr> zz    context#util#map('zz')
" nnoremap <silent> <expr> zb    context#util#map('zb')
" nnoremap <silent> <expr> zt    context#util#map_zt()
" " nnoremap <silent> <expr> H     context#util#map_H()
" " }
" " { nvim-treesitter/nvim-treesitter
" " Improve syntax parsing
" " TSInstall {language} to install one or more parsers. TSInstall <tab> will give you a list of supported languages, or select all to install them all.
" " TSInstallInfo to know which parser is installed.
" " TSUpdate to update already installed parsers
" Plug 'nvim-treesitter/nvim-treesitter'
" " }

call plug#end()
