function! ChangeWindow (number)
  execute a:number . 'wincmd w'
endfunction
function! ArrangeOneLargeVertical ()
  wincmd H
  call ArrangeAllHorizontal(1)
  call ChangeWindow(0)
  wincmd H
endfunction
function! ArrangeOneLargeHorizontal ()
  wincmd K
  call ArrangeAllVertical(1)
  call ChangeWindow(0)
  wincmd K
endfunction
function! ArrangeAllVertical (startingAt)
  let x = range(a:startingAt, winnr('$'))
  for i in reverse(x)
    call ChangeWindow(a:startingAt)
    execute 'wincmd L'
  endfor
endfunction
function! ArrangeAllHorizontal (startingAt)
  let x = range(a:startingAt, winnr('$'))
  for i in reverse(x)
    call ChangeWindow(a:startingAt)
    wincmd J
  endfor
endfunction
nnoremap \v :call ArrangeOneLargeVertical()<CR>
nnoremap \h :call ArrangeOneLargeHorizontal()<CR>
nnoremap <leader>V :call ArrangeOneLargeVertical()<CR>
nnoremap <leader>H :call ArrangeOneLargeHorizontal()<CR>
