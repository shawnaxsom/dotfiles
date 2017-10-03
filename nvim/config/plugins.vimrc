" { Vim-Plug
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }

call plug#begin('~/.vim/bundle')

" { Plugins
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
  " execute "norm gg:read ~/dotfiles/nvim/bookmarks
  execute "norm mZ"

  execute "norm ggI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  execute "norm I" . substitute(Relpath(expand("%:p")), '/', ' > ', 'g') . "
  " execute "norm I> " . substitute(substitute(fnamemodify(expand("%"), ":~:."), '/', '', ''), '/', ' > ', 'g') . "
  execute "norm I~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  " execute "norm G:read ~/dotfiles/nvim/bookmarks\<cr>"
  call feedkeys("")

  " execute "norm 2\<c-o>0"
  execute "norm 1\<c-o>0"
endfunction
augroup dirvish
  autocmd!
  autocmd FileType dirvish nnoremap <buffer> <leader>r :Shdo! mv {} {}<CR>
  autocmd FileType dirvish nnoremap <buffer> <leader>c :Shdo! cp -R {} {}:h<CR>
  autocmd FileType dirvish nnoremap <buffer> <leader>d :Shdo! rm -rf {} {}:h<CR>
  autocmd FileType dirvish nnoremap <buffer> e :e %
  autocmd FileType dirvish nnoremap <buffer> cp :call feedkeys(':!cp ' . expand('<cWORD>') . ' %')<CR>
  autocmd FileType dirvish nnoremap <buffer> mk :Mkdir %
  autocmd FileType dirvish nnoremap <buffer> mv :call feedkeys(':!mv ' . expand('<cWORD>') . ' ' . expand('<cWORD>'))<CR>
  autocmd FileType dirvish nnoremap <buffer> dd :call feedkeys(':!rm -rf ' . expand('<cWORD>'))<CR>
  autocmd FileType dirvish nnoremap <buffer> ! :Shdo! {}<LEFT><LEFT><LEFT><SPACE>
  autocmd FileType dirvish nnoremap <buffer> b :norm gg<CR>:0read ~/dotfiles/nvim/bookmarks<CR>

  " Enable :Gstatus and friends.
  autocmd FileType dirvish call fugitive#detect(@%)
  " autocmd FileType dirvish call InsertBookmarks()
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
Plug 'junegunn/gv.vim'
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
map <leader>gv :GV<CR>
" }
" { GitGutter
Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0
noremap ]c :GitGutterNextHunk<CR>
noremap [c :GitGutterPrevHunk<CR>
noremap <leader>j :GitGutterNextHunk<CR>
noremap <leader>k :GitGutterPrevHunk<CR>
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
" Plug 'ervandew/supertab'
" let g:SuperTabDefaultCompletionType = '<C-n>'
" let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
" }
" { Deoplete
" Unlike YouCompleteMe, Deoplete allowed completion in buffer of a variable
" followed by a property in a string. "rodDimensions." showed all props of
" random variable.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'othree/jspc.vim'
" Deoplete might have less flickering with this
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 30
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
let g:jsx_ext_required = 0
" let g:deoplete#omni#functions.javascript = [
"   \ 'htmlcomplete#CompleteTags',
"   \ 'jspc#omni',
" \]
" }
" { deoplete-ternjs
" TODO TernJS slows down Deoplete considerably
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g tern' }
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni',
\]
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for
" properties) between the completions and the origin position in the result
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some
" heuristics to try and return some properties anyway. Set this to 0 to
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been
" spelled out by at least to characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]
" }
" { vim-polyglot
" Collection of language plugins.
" Includes: 'pangloss/vim-javascript'
" Includes: 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
" let g:javascript_conceal_function                  = "ƒ"
" let g:javascript_conceal_null                      = "ø"
" let g:javascript_conceal_this                      = "@"
" let g:javascript_conceal_return                    = "◁"
" let g:javascript_conceal_undefined                 = "¿"
" let g:javascript_conceal_NaN                       = "ℕ"
" let g:javascript_conceal_prototype                 = "¶"
" let g:javascript_conceal_static                    = "•"
" let g:javascript_conceal_super                     = "Ω"
" let g:javascript_conceal_arrow_function            = "➜"
" let g:javascript_conceal_noarg_arrow_function      = "🞅"
" let g:javascript_conceal_underscore_arrow_function = "🞅"
set conceallevel=0
set concealcursor=
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
nmap <leader>S yiwV:s/"/
vmap <leader>S :s/
" nmap <leader>s yiwV:S/"/
nmap <leader>s yiwV:S/
vmap <leader>s :S/
nmap <leader><leader>S :%s//
vmap <leader><leader>S y:%s/+/
nmap <leader><leader>s :%S//
vmap <leader><leader>s y:%S/+/
" }
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
Plug 'blueyed/vim-qf_resize'
" }
" { ALE
" " :ALEFix to autogically fix any lint errors that have an obvious fix.
" " Add rules to ~/.eslintrc to ignore certain lint errors.
" Plug 'w0rp/ale'  " Async linting
" nnoremap <leader>F :ALEFix<CR>:ALELint<CR>:ALEFirst<CR>
" nnoremap + :ALEFix<CR>:ALELint<CR>:ALEFirst<CR>
" let g:ale_list_window_size = 2
" let g:ale_javascript_eslint_executable='/usr/local/bin/eslint'
" let g:ale_javascript_eslint_use_global = 1
" let g:ale_fixers = { 'javascript': [ 'eslint' ] }
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
" Plug 'sbdchd/neoformat'
" let g:neoformat_javascript_prettier = {
"             \ 'exe': 'prettier',
"             \ 'args': ['--trailing-comma all', '--no-bracket-spacing'],
"             \ }
"             " \ 'args': ['--trailing-comma all', '--no-bracket-spacing', '--single-quote', '--no-semi'],
"             " \ 'args': ['--trailing-comma all', '--no-bracket-spacing'],
" let g:neoformat_enabled_javascript = ['prettier']
" let g:neoformat_verbose = 0
" nmap <silent> = :Neoformat prettier<CR>:ALEFix<CR>:ALELint<CR>:w<CR>:redraw<CR>:lfirst<CR>
" let g:neoformat_try_formatprg = 1
" let g:neoformat_basic_format_align = 1
" let g:neoformat_basic_format_retab = 1
" let g:neoformat_basic_format_trim = 1
" let g:neoformat_only_msg_on_error = 1
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
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let s:prevcountcache=[[], 0]
" let g:airline#extensions#tabline#enabled = 0
" let g:airline_powerline_fonts = 0
" " let g:airline_theme='minimalist'
" " let g:airline_theme='deus'
" " let g:airline_theme='hybrid'
" " let g:airline_theme='dracula'
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
noremap <leader>r :RandomColorScheme<CR>:colo<CR>
" }
" { matchmaker
" Highlight word under cursor
Plug 'qstrahl/vim-matchmaker'
let g:matchmaker_enable_startup = 1
let g:matchmaker_matchpriority = 1
" }
" { FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
" Search all lines in all files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
nnoremap <leader>O :FZFMru<CR>
nnoremap <leader>B :Buffers<CR>
" " " nnoremap <silent> <c-f> :BLines<CR>
" " let g:fzf_buffers_jump = 1
" nnoremap <c-p> :FZF<CR>
" nnoremap <leader>p :FZF<CR>
" nnoremap <c-b> :Buffers<CR>
" nnoremap <leader>b :Buffers<CR>
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
" { kana/vim-textobj-user
Plug 'kana/vim-textobj-user'
" }
" { BufSurf
" Buffer history navigation
" Plug 'ton/vim-bufsurf'
" nmap <silent> H :BufSurfBack<CR>
" nmap <silent> L :BufSurfForward<CR>
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
" Plug 'janko-m/vim-test'
" TODO: They are going to be fixing the issue with not finding Jest in
"       package.json
" nmap <silent> ,t :TestFile<CR>
" " tnoremap <Leader><ESC> <C-\><C-n>
" let g:test#runners = {'javascript': ['jest']}
" let g:test#javascript#karma#file_pattern = 'jest'
" let g:test#javascript#jest#file_pattern = '.test.js$'
" let g:test#javascript#jest#executable = 'npm test'
" let g:test#strategy = "neovim"
" " let test#strategy = "neoterm"
" " let test#strategy = "dispatch"
" let test#javascript#jest#options = { 'suite': '--bail', }

" }
" { BufExplorer
nmap <leader><leader>l :BufExplorer<CR>gg4j
Plug 'jlanzarotta/bufexplorer'
let g:bufExplorerDisableDefaultKeyMapping = 1
let g:bufExplorerSortBy='fullpath'
" }
" { djoshea/vim-autoread
Plug 'djoshea/vim-autoread'
" }
" { edkolev/tmuxline.vim
" Use your Airline theme automatically in Tmux
Plug 'edkolev/tmuxline.vim'
" }
" { yegappan/mru
" Plug 'yegappan/mru'
" nmap <leader><leader>p :MRU<CR>
" }
" { plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_level = 2
let g:vim_markdown_folding_disabled = 0
" }
" " { vimwiki/vimwiki
" Plug 'vimwiki/vimwiki'
" let g:vimwiki_map_prefix = '<Leader>e'
" let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

" augroup vimwiki
"   autocmd!
"   autocmd BufLeave   *.wiki silent w
" augroup END
" " }
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
" { yuttie/comfortable-motion.vim
" Plug 'yuttie/comfortable-motion.vim'
" " let g:comfortable_motion_no_default_key_mappings = 1
" nnoremap <silent> J :call comfortable_motion#flick(100)<CR>
" nnoremap <silent> K :call comfortable_motion#flick(-100)<CR>
" " let g:comfortable_motion_friction = 150.0
" " let g:comfortable_motion_air_drag = 3.0
" " let g:comfortable_motion_friction = 100.0
" " let g:comfortable_motion_air_drag = 2.0
" }
" { terryma/vim-smooth-scroll
" Plug 'terryma/vim-smooth-scroll'
" nnoremap <silent> J :call smooth_scroll#down(&scroll*1/2, 20, 1)<CR>
" nnoremap <silent> K :call smooth_scroll#up(&scroll*1/2, 20, 1)<CR>
" }
" { blueyed/vim-diminactive
" Dim background color of inactive panes
" Uses ColorColumn for highlighting color by default
" Plug 'blueyed/vim-diminactive'
" }
" { ap/vim-buftabline
Plug 'ap/vim-buftabline'
" }
" { Nova colorscheme
Plug 'zanglg/nova.vim'
" }
" { Valloric/MatchTagAlways
" Similar to matchmaker, but for highlighting surrounding tag
Plug 'Valloric/MatchTagAlways'
let g:mta_filetypes = {
\ 'javascript.jsx': 1,
\ 'html' : 1,
\ 'xhtml' : 1,
\ 'xml' : 1,
\ 'jinja' : 1,
\ }
" }

call plug#end()