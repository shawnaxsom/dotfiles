function! ExtractToFile ()
  '<,'>delete a
  let filename = input("Extract to new filename: ")

  if filename !~ '.*\.[a-zA-Z]\{0,3\}'
    let filename = filename . '.js'
  endif

  execute 'sp ' . expand('%:p:h') . '/' . filename
  normal! "aP
endfunction

vnoremap \f :<c-u>call ExtractToFile()<CR>
nnoremap \m "ayiw?^  [a-zA-Z]kOoa() {}k
