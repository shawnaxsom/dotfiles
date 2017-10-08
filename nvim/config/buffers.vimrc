nmap <leader>c :bdelete!<CR>
nmap <leader><leader>a :%argdelete<CR>
nmap <leader>a :args **/**<LEFT>
nmap <leader>! :argdo<space>
nmap <silent> <leader><leader>c :%bdelete!<CR>
nnoremap <leader>l :ls<CR>

nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=*/env/*,*/dist/*,*/bower_components/*,*/tmp/*,*/jest/*
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=tags
set wildignore+=*.tar.*

function! WhatChangedLines ()
  let lines = split(system("git whatchanged --oneline --name-only --since='1 month ago' --author='hawn' --pretty=format:"), "\n")
  if len(lines) == 0
    let lines = split(system("git whatchanged --oneline --name-only --since='1 month ago' --pretty=format:"), "\n")
  endif
  if len(lines) == 0
    let lines = split(system("git whatchanged --oneline --name-only --since='1 year ago' --pretty=format:"), "\n")
  endif
  return lines
endfunction
function! WhatChangedComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(WhatChangedLines(), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! WhatChangedQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(WhatChangedLines(), a:arg)
endfunction
command! -nargs=* -complete=customlist,WhatChangedComplete QuicklyWhatChanged call WhatChangedQuickfixOrGotoFile(<q-args>)
nnoremap <leader>W :QuicklyWhatChanged<space>

function! AnyLines (ArgLead)
  let lines = GetMatches(BufferLines(), a:ArgLead)
  let lines = Dedup(extend(lines, GetMatches(MruLines(), a:ArgLead)))
  let lines = Dedup(extend(lines, GetMatches(WhatChangedLines(), a:ArgLead)))

  if len(lines) == 0
    let lines = extend(lines, FilesLines(a:ArgLead))
  endif
  return lines
endfunction

function! MostRecentlyModifiedLines ()
  return split(system("find . -type f -print0 | xargs -0 stat -f '%m %N' | grep -v '.git\|node_modules' | sort -rn | head -100 | cut -f2- -d' '"), "\n")
endfunction
function! MostRecentlyModifiedComplete (ArgLead, CmdLine, CursorPos)
  return ListComplete(MostRecentlyModifiedLines(), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function! MostRecentlyModifiedQuickfixOrGotoFile (arg)
  call QuickfixOrGotoFile(MostRecentlyModifiedLines(), a:arg)
endfunction
command! -nargs=* -complete=customlist,MostRecentlyModifiedComplete QuicklyMostRecentlyModified call MostRecentlyModifiedQuickfixOrGotoFile(<q-args>)
nnoremap <leader>M :QuicklyMostRecentlyModified<space>
