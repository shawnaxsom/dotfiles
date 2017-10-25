" http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
"
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --case-sensitive
elseif executable('rg')
  set grepprg=rg
elseif executable('ack')
  set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
endif

function! GrepAndJumpIfSingleResult (args, exclude_current_file, always_jump_to_first_result)
  let results = split(system(&grepprg . " " . string(a:args)), '\n')

  if a:exclude_current_file == 1
    let results = filter(results, 'v:val != expand("%")')
  endif

  let results = map(copy(results), '{"filename": split(v:val, ":")[0], "text": join(split(v:val, ":")[2:], ":"), "lnum": split(v:val, ":")[1]}')

  call setqflist(results)

  if len(getqflist()) <= 1
    cclose
  elseif len(getqflist()) > 1
    copen
  endif

  if len(getqflist()) == 1 || a:always_jump_to_first_result == 1
    cfirst
  endif
endfunction
command! -bang -nargs=* -complete=file Grep silent! grep! <args>
" command! -bang -nargs=* -complete=file Grep silent! call GrepAndJumpIfSingleResult(<args>, 0, 0)


nmap <leader>8 "hyiw:Grep <c-r>h<CR>:nohlsearch<CR>
vmap <leader>8 "hy:Grep '<c-r>h'<CR>
nmap <leader>/ "hyiw:Grep ""<left>
nmap <leader>./ :Grep "" %:p:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>../ :Grep "" %:p:h:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>.8 "hyiw:Grep <c-r>h %:p:h/*<CR><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>..8 "hyiw:Grep <c-r>h %:p:h:h/*<CR><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader><leader>. :Grep "" %:p:h:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

nnoremap <silent> gr :call GrepAndJumpIfSingleResult("import.*/" . expand("%:t:r") . '"', 1, 1)<CR>

" open the quickfix window automatically
" augroup automaticquickfix
"   autocmd!
"   autocmd QuickFixCmdPost [^l]* cwindow
"   autocmd QuickFixCmdPost    l* lwindow
" augroup END
