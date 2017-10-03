" { Buffers and Find
" Tips:
" Add searches to buffers GrepperAg, then load all to buffer with: :cdo badd %
" Delete all buffers: :bufdo bd
" * C-A to auto complete all glob matches, e.g. :bd **/*<CA>
nmap <leader>c :bdelete!<CR>
nmap <leader><leader>a :%argdelete<CR>
nmap <leader>a :args **/**<LEFT>
nmap <leader>! :argdo<space>
nmap <silent> <leader><leader>c :%bdelete!<CR>
" nmap <leader><leader>f :filter // ls<LEFT><LEFT><LEFT><LEFT>

" noremap <c-p> :find *
" noremap <leader>p :find *
" noremap <leader>f :find *
function! FilterFind ()
  let name = input('Find: ')
  if name == ""
    call feedkeys(":find **/*" . name . "*\<LEFT>")
  else
    call feedkeys(":find **/*" . join(split(name, " "), "*/**/*") . "*\<c-d>\<tab>")
  endif
endfunction
noremap <leader><leader>f :call FilterFind()<CR>
noremap <leader>f :find *

" Tell vim to remember certain things when we exit
"  '50  :  MRU / :oldfiles - marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
if has('nvim')
  set shada='50,\"1000,:1,n~/.vim/shada
else
  set viminfo=\'50,\"100,:20,%
endif
augroup oldfiles_refresh
  autocmd!
  " :h oldfiles - only refreshed on startup or with this command
  autocmd BufEnter,BufLeave * :wshada!
  autocmd BufEnter,BufLeave * :rshada!
augroup END
function! FilterOldfiles ()
  let name = input('MRU File: ')
  if name == ""
    call feedkeys(":browse oldfiles\<CR>")
  else
    call feedkeys(":filter " . join(split(name, " "), ".*/.*/.*") . " browse oldfiles\<CR>")
  endif
endfunction
noremap <leader>o :filter /src/ browse oldfiles<CR>
noremap <leader><leader>o :call FilterOldfiles()<CR>
" noremap <leader>m :call FilterOldfiles()<CR>
" noremap <leader>o :MRU<space>
" " noremap <leader>m :MRU<space>
" noremap <leader>o :browse oldfiles<CR>

function! FilterBuffers ()
  let name = input('Buffer: ')
  call feedkeys(":filter " . join(split(name, " "), "*") . " browse oldfiles\<CR>")
endfunction
nmap <leader><leader>b :call FilterBuffers()<CR>
noremap <leader>b :b<space>
nmap <leader><leader>p :call FilterBuffers()<CR>
noremap <leader>p :b<space>
noremap <c-p> :b<space>


nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=env/,dist/,bower_components/,tmp/,jest/
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
" }
