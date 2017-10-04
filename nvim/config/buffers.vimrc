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

function! FilterOldfiles ()
  let name = input('MRU File: ')
  if name == ""
    call feedkeys(":browse oldfiles\<CR>")
  else
    call feedkeys(":filter " . join(split(name, " "), ".*/.*/.*") . " browse oldfiles\<CR>")
  endif
endfunction


" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
  let lines = extend(
    \ filter(copy(v:oldfiles),
    \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))

  for word in split(a:CmdLine, " ")[1:]
      let lines = filter(lines, 'v:val =~ "' . word . '"')
  endfor

  return lines
endfunction

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

  echom a:arg

  for word in split(a:arg, " ")
    let lines = filter(lines, 'v:val =~ "' . word . '"')
  endfor

  if len(lines) == 1
    execute 'e ' . lines[0]
  else
    let data = map(copy(lines), '{"filename": v:val, "text": "", "lnum": ""}')
    call setqflist(data)
    copen
  endif
endfunction
" command! -nargs=1 -complete=customlist,<sid>MRUComplete MRU call MRU(<f-args>)
command! -nargs=* -complete=customlist,<sid>MRUComplete MRU call MRU(<q-args>)
noremap <leader>o :MRU<space>
noremap <leader><leader>o :call FilterOldfiles()<CR>


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
