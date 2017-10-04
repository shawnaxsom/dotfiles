" Always show the statusline
set laststatus=2

" Reset any previous configuration if editing this file
set statusline=

function! IsModified()
  return 1
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! ShowFuncName()
  let save_pos = getpos(".")
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  call search('^[ ]\{0,2\}[a-zA-Z]', 'bW')
  let line = getline(".")
  echohl None
  call setpos('.', save_pos)
  return line
endfun
map <leader>X :echo ShowFuncName()<CR>

" hi StatusLine guibg=#0333f3
" hi StatusLineNC guibg=#533333
hi StatusLineFile guibg=#9bcb8b
hi StatusLineFileInactive guibg=#7bab9b
hi StatusLineExtension guibg=#000000
hi StatusLineFolder guibg=#333333
hi StatusLineActive guibg=#444444
hi StatusLineInactive guifg=#f88888 guibg=#101a1f
" }

hi User1 term=inverse,bold gui=inverse,bold guifg=#ff0000
hi User2 guibg=#bbcbfb

function! SetActiveStatusLine ()
  let g:git_branch = GitBranch()

  setlocal statusline=
  setlocal statusline+=%1*%m  " Modifications, highlighted with User1 (red)
  setlocal statusline+=%#StatusLineFile# " Change colors
  setlocal statusline+=\ \ %{expand('%:t:r')}
  setlocal statusline+=\ %#StatusLineExtension# " Change colors
  setlocal statusline+=\ %{expand('%:t:e')}

  setlocal statusline+=\ %#StatusLineFolder# " Change colors
  setlocal statusline+=\ \ \ %{expand('%:h:h:t')}
  setlocal statusline+=/%{expand('%:h:t')}

  setlocal statusline+=\ \ %#StatusLineActive# " Change colors

  setlocal statusline+=%=        " Switch to the right side
  setlocal statusline+=%<        " Truncate here if too long
  setlocal statusline+=%{g:git_branch}
  " setlocal statusline+=\ %{fugitive#statusline()}
  setlocal statusline+=\ |
  " setlocal statusline+=%{ShowFuncName()}
  " setlocal statusline+=%#warningmsg#
endfunction

function! SetInactiveStatusLine ()
  let g:git_branch = GitBranch()

  setlocal statusline=
  setlocal statusline+=%1*%m  " Modifications, highlighted with User1 (red)
  setlocal statusline+=%#StatusLineFileInactive# " Change colors
  setlocal statusline+=\ \ %{expand('%:t:r')}
  setlocal statusline+=\ %#StatusLineExtension# " Change colors
  setlocal statusline+=\ %{expand('%:t:e')}

  setlocal statusline+=\ %#StatusLineFolder# " Change colors
  setlocal statusline+=\ \ \ %{expand('%:h:h:t')}
  setlocal statusline+=/%{expand('%:h:t')}

  setlocal statusline+=\ \ %#StatusLineInactive#" Change colors

  setlocal statusline+=%=        " Switch to the right side
  setlocal statusline+=%<        " Truncate here if too long
  setlocal statusline+=%{g:git_branch}
  " setlocal statusline+=\ %{fugitive#statusline()}
  setlocal statusline+=\ |
  " setlocal statusline+=%{ShowFuncName()}
  " setlocal statusline+=%#warningmsg#
endfunction

augroup statusline
  autocmd!
  autocmd BufEnter * call SetActiveStatusLine()
  autocmd BufLeave * call SetInactiveStatusLine()
augroup END

call SetActiveStatusLine()

" set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'
