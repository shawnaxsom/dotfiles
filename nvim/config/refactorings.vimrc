function! ExtractMethod ()
  '<,'>delete a
  let methodname = input("Extract to method name: ")

  execute "normal! O" . methodname . "();"

  normal! ?^  [a-zA-Z]kO

  execute "normal! o" . substitute(methodname, "this.", "", "") . "() {}"
  normal! "aP
  normal! vi{=
endfunction

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
vnoremap \m :<c-u>call ExtractMethod()<CR>
