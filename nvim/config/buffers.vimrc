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

" function! FilterFind ()
"   let name = input('Find: ')
"   if name == ""
"     call feedkeys(":find **/*" . name . "*\<LEFT>")
"   else
"     call feedkeys(":find **/*" . join(split(name, " "), "*/**/*") . "*\<c-d>\<tab>")
"   endif
" endfunction
" noremap <leader>f :find *

function! FilterOldfiles ()
  let name = input('MRU File: ')
  if name == ""
    call feedkeys(":browse oldfiles\<CR>")
  else
    call feedkeys(":filter " . join(split(name, " "), ".*/.*/.*") . " browse oldfiles\<CR>")
  endif
endfunction

function! Dedup (lines)
  return filter(copy(a:lines), 'index(a:lines, v:val, v:key+1)==-1')
endfunction

" MRU command-line completion
function! ListComplete(lines, ArgLead, CmdLine, CursorPos)
  let lines = a:lines

  for word in split(a:CmdLine, " ")[1:]
    let lines = filter(lines, 'v:val =~ "' . word . '"')
  endfor

  let lines = Dedup(lines)

  return lines
endfunction
function! GetMatches (lines, arg)
  " Good resources for some of the code here, some lines were borrowed:
  " * https://github.com/junegunn/fzf/issues/301
  " * https://vi.stackexchange.com/questions/6019/is-it-possible-to-populate-the-quickfix-list-with-the-errors-of-vimscript-functi
  " * https://www.reddit.com/r/vim/comments/finj2/how_do_you_put_information_in_the_quickfix_window/
  " * https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/
  " * http://learnvimscriptthehardway.stevelosh.com/chapters/40.html
  " * https://github.com/romainl/vim-tinyMRU
  let lines = a:lines

  for word in split(a:arg, " ")
    let lines = filter(lines, 'v:val =~ "' . word . '"')
  endfor

  let lines = Dedup(lines)

  " Remove relative path prefix, not necessary if your path is correct and can
  " lead to duplicates if some have relative path and some don't.
  let lines = Dedup(map(copy(lines), 'substitute(v:val, "^./", "", "g")'))

  return lines
endfunction
function! QuickfixOrGotoFile (lines, arg)
  let lines = GetMatches(a:lines, a:arg)

  if len(lines) > 0
    " echom 'e ' . lines[0]
    execute 'e ' . lines[0]
    " if len(lines) == 1
    "   echom 'e ' . lines[0]
    "   execute 'e ' . lines[0]
    " else
    "   echom string(lines)
    "   let data = map(copy(lines), '{"filename": v:val, "text": "", "lnum": ""}')
    "   call setqflist(data)
    "   copen
    " endif
  endif
endfunction


function! MruLines ()
  return extend(
    \ filter(copy(v:oldfiles),
    \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction
function! MruComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(MruLines(), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! MruQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(MruLines(), a:arg)
endfunction
command! -nargs=* -complete=customlist,MruComplete MRU call MruQuickfixOrGotoFile(<q-args>)
noremap <leader>o :MRU<space>


function! BuffersLines ()
  return map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)')
endfunction
function! BuffersComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(BuffersLines(), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! BuffersQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(BuffersLines(), a:arg)
endfunction
command! -nargs=* -complete=customlist,BuffersComplete BUFFERS call BuffersQuickfixOrGotoFile(<q-args>)
noremap <leader>b :BUFFERS<space>


function! FilesLines (ArgLead)
  if a:ArgLead =~ '\.\/.*' || a:ArgLead =~ '\/.*'
    " User must have used completion, last argument is probably full path
    let args = split(a:ArgLead, ' ')
    return [ args[len(args) - 1] ]
  endif

  " Just uses the first word if there are multiple. A little slower
  " but more flexible in ordering of words and subdirectories.
  " Other words get filtered out in QuickfixOrGotoFile()
  let firstArg = split(a:ArgLead, ' ')[0]
  " let lines = globpath('.', '**/*' . firstArg . '*', 0, 1)
  " Limit to just JavaScript for now, and don't include folders
  " let lines = globpath('.', '**/*' . firstArg . '*/**/*.js', 0, 1)
  " echom firstArg
  " echom string(lines)
  " echom "find . -path '*" . firstArg . "*' -type f"
  " echom system("find . -path '*" . firstArg . "*' -type f")
  let excludeFolders = '-not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/bower_components/*"'
  let lines = split(system("find . -path '*" . firstArg . "*' -type f " . excludeFolders), '\n')
  " echom string(lines)
  return lines
endfunction
function! FilesComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(FilesLines(a:ArgLead), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! FilesQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(FilesLines(a:arg), a:arg)
endfunction
command! -nargs=* -complete=customlist,FilesComplete FILES call FilesQuickfixOrGotoFile(<q-args>)
noremap <leader>f :FILES<space>


function! AllLines (ArgLead)
  let lines = GetMatches(BuffersLines(), a:ArgLead)

  if len(lines) == 0
    let lines = extend(lines, GetMatches(MruLines(), a:ArgLead))
  endif

  if len(lines) == 0
    " Only run FilesLines if no matches from other two? For performance.
    let lines = extend(lines, FilesLines(a:ArgLead))
  endif
  return lines
endfunction
function! AllComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(AllLines(a:ArgLead), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! AllQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(AllLines(a:arg), a:arg)
endfunction
command! -nargs=* -complete=customlist,AllComplete ALL call AllQuickfixOrGotoFile(<q-args>)
noremap <leader>p :ALL<space>
noremap <c-p> :ALL<space>


nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=*/env/*,*/dist/*,*/bower_components/*,*/tmp/*,*/jest/*
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=tags
set wildignore+=*.tar.*
" }
