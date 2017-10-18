" -----------------------------------------------------------------------------------------
" Terminal mappings
" -----------------------------------------------------------------------------------------
function! OpenTerminalHere ()
  execute "sp term://cd '" . expand("%:p:h") . "'; fish"
  startinsert
endfunction
nmap <silent> <leader>t :call OpenTerminalHere()<CR>
nmap ,b :sp term://bash %:p<CR>
nmap ,r :sp term://npm start<CR>
nmap ,t :sp term://npm run test<CR>
map ,q :sp term://env NODE_ENV=qa npm start<CR>
augroup vimux
  autocmd!
  autocmd BufEnter */api/* map <buffer> ,r :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,q :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,t :sp term://npm test -- --tests " . expand("%"))<CR>
" map ,t :Dispatch npm test<CR>
augroup END
" nmap <leader>O :call LetMeDuckThatForYou(&filetype . ' ' . '<c-r><c-w>')<CR>
" nmap <leader>o :call LetMeDuckThatForYou('')<CR>
" vmap <leader>o y:call LetMeDuckThatForYou(&filetype . ' ' . @+)<CR>
nmap <C-\> <C-\><C-n> :wincmd p<CR>
tnoremap <C-\> <C-\><C-n>
tnoremap <C-u> <C-\><C-n><C-u>
tnoremap <C-d> <C-\><C-n><C-d>
tnoremap <C-h> <C-\><C-n>:wincmd h<CR>
tnoremap <C-j> <C-\><C-n>:wincmd j<CR>
tnoremap <C-k> <C-\><C-n>:wincmd k<CR>
tnoremap <C-l> <C-\><C-n>:wincmd l<CR>
" }
