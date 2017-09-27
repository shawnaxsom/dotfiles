" { Mappings

" URL encode a string. ie. Percent-encode characters as necessary.
function! UrlEncode(string)

    let result = ""

    let characters = split(a:string, '.\zs')
    for character in characters
        if character == " "
            let result = result . "+"
        elseif CharacterRequiresUrlEncoding(character)
            let i = 0
            while i < strlen(character)
                let byte = strpart(character, i, 1)
                let decimal = char2nr(byte)
                let result = result . "%" . printf("%02x", decimal)
                let i += 1
            endwhile
        else
            let result = result . character
        endif
    endfor

    return result

endfunction

" Returns 1 if the given character should be percent-encoded in a URL encoded
" string.
function! CharacterRequiresUrlEncoding(character)

  let ascii_code = char2nr(a:character)
  if ascii_code >= 48 && ascii_code <= 57
    return 0
  elseif ascii_code >= 65 && ascii_code <= 90
    return 0
  elseif ascii_code >= 97 && ascii_code <= 122
    return 0
  elseif a:character == "-" || a:character == "_" || a:character == "." || a:character == "~"
    return 0
  endif

  return 1

endfunction

function! LetMeDuckThatForYou(defaultPhrase)
  " let search = UrlEncode(a:foo)
  " let search = 'foo'
  " echo 'sp term://elinks https://www.google.com/search?q=' . search
  " execute 'sp term://surfraw google ' . search
  " execute 'sp term://elinks www.google.com/search?q=' . search
  " execute 'sp term://elinks www.google.com/search?q=foo'
  " execute 'sp term://googler --count 2 ' . search
  " execute 'norm :sp term://googler --count 2 ' . search
  " call feedkeys(":sp")
  " call feedkeys(':sp term://googler --count 2 ' . a:foo)
  " call feedkeys(':vsp term://env BROWSER=elinks googler --count 3 ' . a:foo)
  " let searchCommand = ':vsp term://env BROWSER=w3m googler --count 3 '

  " let searchCommand = ':vsp term://env BROWSER=elinks googler --count 3 '
  " let searchCommand = searchCommand . a:foo

  call inputsave()
  let phrase = input('', a:defaultPhrase)
  call inputrestore()

  let searchCommand = ':vsp term://elinks duckduckgo.com/?q='
  let searchCommand = searchCommand . UrlEncode(phrase)

  execute '!open https://duckduckgo.com/?q=' . UrlEncode(phrase)
endfunction

" { Terminal
nmap <silent> <leader>t :sp term://fish<CR>i
nmap ,b :sp term://bash %:p<CR>
nmap ,r :sp term://npm start<CR>
map ,q :sp term://env NODE_ENV=qa npm start<CR>
augroup vimux
  autocmd!
  autocmd BufEnter */api/* map <buffer> ,r :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,q :sp term://npm run build; NODE_ENV=qa npm start")<CR>
  autocmd BufEnter */api/* map <buffer> ,t :sp term://npm test -- --tests " . expand("%"))<CR>
" map ,t :Dispatch npm test<CR>
augroup END
nmap <leader>O :call LetMeDuckThatForYou(&filetype . ' ' . '<c-r><c-w>')<CR>
nmap <leader>o :call LetMeDuckThatForYou('')<CR>
vmap <leader>o y:call LetMeDuckThatForYou(&filetype . ' ' . @+)<CR>
nmap <C-\> <C-\><C-n> :wincmd p<CR>
tnoremap <C-\> <C-\><C-n>
tnoremap <C-h> <C-\><C-n>:wincmd h<CR>
tnoremap <C-j> <C-\><C-n>:wincmd j<CR>
tnoremap <C-k> <C-\><C-n>:wincmd k<CR>
tnoremap <C-l> <C-\><C-n>:wincmd l<CR>
" }

function! SetScratchBuffer()
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction
function! DiffThis()
  normal! ?^<<<<<<<
  normal! j
  normal! V
  normal! /^=======
  normal! k
  normal! "ay

  /^=======
  normal! j
  normal! V
  /^>>>>>>>
  normal! k
  normal! "by
  normal! 

  silent split /tmp/a.js
  call SetScratchBuffer()

  normal! ggVGd
  normal! "aP
  diffthis

  silent vsplit /tmp/b.js
  call SetScratchBuffer()

  normal! ggVGd
  normal! "bP
  diffthis

endfunction

" { Leader <Space>

" copy current absolute filename into register
nnoremap <leader>yf :let @*=expand('%:p')<CR>
" copy file contents
" nnoremap <leader>yf :%y+<cr>

nmap <leader><leader>i :PlugInstall<CR>
nmap <leader><leader>u :PlugClean!<CR>
nmap <leader>ev :vsp ~/.config/nvim/init.vim<CR>
nmap <leader><leader>t :sp ~/dotfiles/.ctags<CR>

nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>
nmap <leader>h :sp<CR>
nmap <leader>v :vsp<CR>
nmap <leader>w :w<CR>

" Switch to previous file
map <leader><tab> <c-^>

nmap <leader>0 :set foldlevel=0<CR>
nmap <leader>1 :set foldlevel=1<CR>
nmap <leader>2 :set foldlevel=2<CR>
nmap <leader>3 :set foldlevel=3<CR>
nmap <leader>4 :set foldlevel=4<CR>
nmap <leader>5 :set foldlevel=5<CR>
nmap <leader>6 :set foldlevel=6<CR>
nmap <leader>7 :set foldlevel=7<CR>
nmap <leader>9 :set foldlevel=999<CR>

" }

" { Visual Mode
vmap I :norm I
vmap A :norm A
vmap <enter> :norm<space>
vmap <bar> :g/
nmap <leader>l yiw{oconsole.warn(`"`, ")^
vmap <leader>l y{oconsole.warn(`"`, ")^
vnoremap <c-p> :<c-p>
" }

map ! :!

" { Navigation in buffer
noremap J 5j
noremap K 5k
map H [{
map L ]}
" }

" { Navigate panes
" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l
" }

imap <c-z> <c-y>,

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" }

" { Default behavior overrides

nmap <enter> vap

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('rg')
  set grepprg=rg
elseif executable('ack')
  set grepprg=ack\ -s\ --nogroup\ --nocolor\ --column\ --with-filename
endif

" When doing commands, always scroll through history matching current text
cmap <c-p> <up>
cmap <c-n> <down>

" noremap ; :

nnoremap g} :split<CR>gd

" Case insensitive search (but still have case sensitive for :substitute
nnoremap / /\c
vnoremap / /\c
nnoremap ? ?\c
vnoremap ? ?\c

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Center screen and open folds when going through search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't skip wrapped lines
nnoremap j gj
nnoremap k gk

" Y should copy to end of line, not full line, same as D
noremap Y y$

nmap [q :cprev<CR>
nmap ]q :cnext<CR>
nmap [b :bprevious<CR>
nmap ]b :bnext<CR>
nmap [a :previous<CR>
nmap ]a :next<CR>

nmap <leader>f <bar>_
nmap <leader><leader>f =
nmap <leader>d =
nmap <leader>= =
nmap <leader>z =
" augroup maximizepane
"   autocmd!
"   autocmd BufWinEnter,WinEnter *{.js,/} :norm |<CR>
"   autocmd BufWinEnter,WinEnter *{.js,/} :norm _<CR>
" augroup END

nmap <leader>; g;999g,
" }

