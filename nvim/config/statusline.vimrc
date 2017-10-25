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

hi StatusLineFile guibg=#9bfb9b guifg=#000000
hi StatusLineFileInactive guibg=#7bbb9b guifg=#504000
hi StatusLineExtensionActive guibg=#ffff00 guifg=#555555
hi StatusLineExtensionInactive guibg=#698a8a guifg=#555555
hi StatusLineActive guibg=#c9fB99
hi StatusLineInactive guibg=#888888
" }

hi User1 term=inverse,bold gui=inverse,bold guifg=#ff0000
hi User2 guibg=#bbcbfb

function! SetActiveStatusLine ()
  let g:git_branch = GitBranch()

  setlocal statusline=
  setlocal statusline+=%1*%m  " Modifications, highlighted with User1 (red)
  setlocal statusline+=%#StatusLineFile# " Change colors
  setlocal statusline+=\ \ %{expand('%:t:r')}
  setlocal statusline+=\ %#StatusLineExtensionActive# " Change colors
  setlocal statusline+=\ %{expand('%:t:e')}

  setlocal statusline+=\ \ %#StatusLineActive# " Change colors
  setlocal statusline+=\ \ \ %{expand('%:h:h:t')}
  setlocal statusline+=/%{expand('%:h:t')}
  setlocal statusline+=/%{expand('%:t')}

  setlocal statusline+=%=        " Switch to the right side
  setlocal statusline+=%<        " Truncate here if too long
  " setlocal statusline+=%{g:git_branch}
endfunction

function! SetInactiveStatusLine ()
  let g:git_branch = GitBranch()

  setlocal statusline=
  setlocal statusline+=%1*%m  " Modifications, highlighted with User1 (red)
  setlocal statusline+=%#StatusLineFileInactive# " Change colors
  setlocal statusline+=\ \ %{expand('%:t:r')}
  setlocal statusline+=\ %#StatusLineExtensionInactive# " Change colors
  setlocal statusline+=\ %{expand('%:t:e')}

  setlocal statusline+=\ \ %#StatusLineInactive#" Change colors
  setlocal statusline+=\ \ \ %{expand('%:h:h:t')}
  setlocal statusline+=/%{expand('%:h:t')}
  setlocal statusline+=/%{expand('%:t')}

  setlocal statusline+=%=        " Switch to the right side
  setlocal statusline+=%<        " Truncate here if too long
  " setlocal statusline+=%{g:git_branch}
endfunction

augroup statusline
  autocmd!
  autocmd BufEnter * call SetActiveStatusLine()
  autocmd BufLeave * call SetInactiveStatusLine()
augroup END

call SetActiveStatusLine()
