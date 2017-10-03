" http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
"
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('rg')
  set grepprg=rg
elseif executable('ack')
  set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
endif

" command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
" command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!
command! -bang -nargs=* -complete=file Grep silent! grep! <args>


nmap <leader>8 "hyiw:Grep <c-r>h<CR>:nohlsearch<CR>
vmap <leader>8 "hy:Grep '<c-r>h'<CR>
nmap <leader>/ "hyiw:Grep ""<left>
" nmap <leader>. :Grep "" %:p:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>./ :Grep "" %:p:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>../ :Grep "" %:p:h:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>.8 "hyiw:Grep <c-r>h %:p:h/*<CR><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader>..8 "hyiw:Grep <c-r>h %:p:h:h/*<CR><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nmap <leader><leader>. :Grep "" %:p:h:h/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <silent> gr :execute 'Grep import.*' . expand("%:t:r")<CR>
nmap <silent> ,/ :nohlsearch<CR>
