function! Lint ()
  let save_pos = getpos(".")
  silent make
  call setpos('.', save_pos)
  if qf#GetList() != []
    cfirst
  endif
endfunction
if executable('eslint')
  " set errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
  set errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
  set makeprg=eslint\ --fix\ --quiet\ -f\ compact\ %
endif

function! Format()
  let save_pos = getpos(".")

  if &formatprg != ""
    silent exe "%!".&formatprg
    if v:shell_error != 0
      let format_error = join(getline(line("'["), line("']")), "\n")
      undo
      " echo format_error
    end
  else
    norm ggVG=
  endif
  call setpos('.', save_pos)
endfunction

nmap <silent> = :call Format()<CR>

augroup lint
  autocmd!
  autocmd BufWritePre *.js call Format()
  autocmd BufWritePost *.js call Lint()
  autocmd FileType json setlocal formatprg=jq\ '.'
  autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier\ --stdin\ --trailing-comma\ all\ --no-bracket-spacing
  autocmd FileType javascript,javascript.jsx nnoremap <buffer> <silent> <leader>l :call Lint()<CR>
augroup END
