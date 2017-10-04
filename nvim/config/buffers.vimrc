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
" nmap <leader><leader>f :filter // ls<LEFT><LEFT><LEFT><LEFT>

" noremap <c-p> :find *
" noremap <leader>p :find *
" noremap <leader>f :find *
function! FilterFind ()
  let name = input('Find: ')
  if name == ""
    call feedkeys(":find **/*" . name . "*\<LEFT>")
  else
    call feedkeys(":find **/*" . join(split(name, " "), "*/**/*") . "*\<c-d>\<tab>")
  endif
endfunction
noremap <leader><leader>f :call FilterFind()<CR>
" command! -bang -complete=file FFind silent! call FilterFind()
noremap <leader>f :find *

" Tell vim to remember certain things when we exit
"  '150  :  MRU / :oldfiles - marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
if has('nvim')
  set shada='150,\"1000,:1,n~/.vim/shada
else
  set viminfo=\'150,\"100,:20,%
endif
function! FilterOldfiles ()
  let name = input('MRU File: ')
  if name == ""
    call feedkeys(":browse oldfiles\<CR>")
  else
    call feedkeys(":filter " . join(split(name, " "), ".*/.*/.*") . " browse oldfiles\<CR>")
  endif
endfunction
" noremap <leader>o :filter /src/ browse oldfiles<CR>


" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
  let lines = extend(
    \ filter(copy(v:oldfiles),
    \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))

  return filter(lines, 'v:val =~ a:ArgLead')
endfunction

" MRU function
function! s:MRUDo(command, arg)
    if a:command == "tabedit"
        execute a:command . " " . a:arg . "|lcd %:p:h"
    else
        execute a:command . " " . a:arg
    endif
endfunction

" commands
" command! -nargs=1 -complete=customlist,<sid>MRUComplete MRU call <sid>MRUDo('edit', <f-args>)
" command! -nargs=1 -complete=customlist,<sid>MRUComplete MS call <sid>MRUDo('split', <f-args>)
" command! -nargs=1 -complete=customlist,<sid>MRUComplete MV call <sid>MRUDo('vsplit', <f-args>)
" command! -nargs=1 -complete=customlist,<sid>MRUComplete MT call <sid>MRUDo('tabedit', <f-args>)
" }

function! MRU (arg)
  " Used some code ideas from these:
  " * https://github.com/junegunn/fzf/issues/301
  " * https://vi.stackexchange.com/questions/6019/is-it-possible-to-populate-the-quickfix-list-with-the-errors-of-vimscript-functi
  " * https://www.reddit.com/r/vim/comments/finj2/how_do_you_put_information_in_the_quickfix_window/
  " * https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/
  let lines = extend(
    \ filter(copy(v:oldfiles),
    \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))

  for word in split(a:arg, " ")
    let lines = filter(lines, 'v:val =~ "' . word . '"')
  endfor

  " let data = map(copy(lines), '{"filename": v:val, "text": "called from here", "lnum": 1}')
  let data = map(copy(lines), '{"filename": v:val, "text": "", "lnum": ""}')

  call setqflist(data)
  copen
endfunction
command! -nargs=1 -complete=customlist,<sid>MRUComplete MRU call MRU(<f-args>)
noremap <leader>o :MRU<space>
noremap <leader><leader>o :call FilterOldfiles()<CR>
" noremap <leader>m :call FilterOldfiles()<CR>
" noremap <leader>o :MRU<space>
" " noremap <leader>m :MRU<space>
" noremap <leader>o :browse oldfiles<CR>

function! FilterBuffers ()
  let name = input('Buffer: ')
  call feedkeys(":filter " . join(split(name, " "), "*") . " browse buffers\<CR>")
endfunction
nmap <leader><leader>b :call FilterBuffers()<CR>
noremap <leader>b :b<space>
nmap <leader><leader>p :call FilterBuffers()<CR>
noremap <leader>p :b<space>
noremap <c-p> :b<space>


nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=env/,dist/,bower_components/,tmp/,jest/
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
" }
