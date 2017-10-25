augroup packagejson
  autocmd!
  autocmd BufEnter package.json nnoremap <buffer><silent> ,r 0wyi":exec 'sp term://npm run ' . @"<CR>:startinsert<CR>
augroup END
