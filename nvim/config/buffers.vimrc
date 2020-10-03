map <leader>e :e **/*
" nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>b :b<space>
nnoremap <leader>d :ls<cr>:bd<home>
nmap <leader>c :bdelete!<CR>
nmap <leader>l :ls<CR>
nmap <leader><leader>a :%argdelete<CR>
nmap <leader>a :args **/**<LEFT>
nmap <leader><leader>a :args<CR>
nmap <leader>! :argdo<space>
nmap <silent> <leader><leader>c :%bdelete!<CR>
" nnoremap <leader>l :ls<CR>
nnoremap <leader>j :jumps<cr>

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! s:ToggleQf()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
      " then it should be the quickfix window
      cclose
      return
    endif
  endfor

  copen
endfunction
" nnoremap <leader>l :call <SID>ToggleQf()<cr>

function! GoToFileIncludeNodeModules ()
  set wildignore-=*/node_modules/*
  set path+=../node_modules/,./node_modules/
  let l:path = expand('<cWORD>')
  echom "Path: " . l:path
  " execute '"pyi"'
  try
    normal! gf
  catch
    " echo expand("%:p:h") . "/" . substitute(substitute(substitute(l:path, '"', '', 'g'), ';', '', 'g'), '^\./', '', '') . ".js"
    execute "e " . expand("%:p:h") . "/" . substitute(substitute(substitute(l:path, '"', '', 'g'), ';', '', 'g'), '^\./', '', '') . ".js"
  endtry
  set wildignore+=*/node_modules/*
  set path-=../node_modules/,./node_modules/
endfunction
" Doesn't work if not js file
" nnoremap gf :call GoToFileIncludeNodeModules()<CR>

nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=*/env/*,*/dist/*,*/bower_components/*,*/.tmp/*,*/tmp/*,*/jest/*
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.tar.*
set wildignore+=*.git/*
set wildignore+=*fonts/*
set wildignore+=*.ico,*.svg,*.png,*.jpg,*.jpeg
set wildignore+=*.DS_STORE*
set wildignore+=*Session.vim*
set wildignore+=*/build/*
set wildignore+=*/.tern-port
set wildignore+=*/bin/*
set wildignore+=*.min.js
set wildignore+=*/.webpack/*
set wildignore+=*/out/*
set wildignore+=*.pyc
set wildignore+=*/htmlcov/*
set wildignore+=*__pycache__/*
set wildignore+=.DS_Store
set wildignore+=*.hpp
set wildignore+=*.map
set wildignore+=*.svg
set wildignore+=*.png
set wildignore+=*/Pods/*
set wildignore+=*/syncTargetSnapshots/*
