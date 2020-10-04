" { Languages

" { Python
let g:pymode_options_max_line_length=120
let g:python_highlight_all=1
augroup pythonsettings
  autocmd!
  autocmd Syntax python setlocal tabstop=4 shiftwidth=4 shiftround expandtab autoindent smarttab smartindent
  autocmd Syntax python setlocal foldmethod=indent
  autocmd Syntax python normal zR
augroup END
augroup pythondispatch
  autocmd!
  autocmd FileType python map <buffer> ,r :Dispatch python %:p<CR>
augroup END
" }

" { Go
autocmd Filetype go setlocal makeprg=go\ build
" }

" {
augroup nginx_ft
  au!
  autocmd BufNewFile,BufRead *.tmpl   set filetype=nginx
augroup END
" }

" { Other Languages
autocmd! Syntax java map <F1> :!javac %:p && java HelloWorld<CR>
autocmd! Syntax ruby map <F1> :!./bin/rails server<CR>
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }

" }

