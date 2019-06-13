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
nmap <leader><leader>t :sp ~/dotfiles/.ctags<CR>

nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>
nmap <leader>h :sp<CR>
nmap <leader>v :vsp<CR>
nmap <leader>w :w<CR>
nmap <leader>x A // ZZZZ<ESC>0
nmap <leader><leader>x :Grep "ZZZZ"<CR>

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
" vmap I :norm i
" vmap A :norm A
" vmap <enter> :norm<space>
vmap <bar> :g/
vnoremap <c-p> :<c-p>
" }

map ! :!

" -----------------------------------------------------------------------------------------
" Smooth Scrolling
" -----------------------------------------------------------------------------------------
let g:is_smooth_scrolling = 0
function! SmoothScroll(direction, screen_fraction)
  if !g:is_smooth_scrolling
    let g:is_smooth_scrolling = 1
    let topline = line("w0")
    let botline = line("w$")
    let lines_per_scroll = 3
    let lines_to_scroll = (botline - topline) / a:screen_fraction

    let c = 0
    while c <= (lines_to_scroll / lines_per_scroll)
      execute 'norm ' . lines_per_scroll . a:direction
      redraw
      sleep 17m
      redraw
      let c += 1
    endwhile
    let g:is_smooth_scrolling = 0
  endif
endfunction
" noremap J 7j
" nnoremap <silent> <c-d> :call SmoothScroll('j', 1)<CR>
" nnoremap <silent> <c-u> :call SmoothScroll('k', 1)<CR>
" nnoremap <silent> J :call SmoothScroll('j', 10)<CR>
" nnoremap <silent> K :call SmoothScroll('k', 10)<CR>
" nnoremap <silent> J 7j
" nnoremap <silent> K 7k
nnoremap <silent> J }
nnoremap <silent> K {
" vnoremap J 2j
" vnoremap K 2k
vnoremap J }
vnoremap K {

" -----------------------------------------------------------------------------------------
" H / L - Navigation in buffer
" -----------------------------------------------------------------------------------------
function! GoToFuncStart()
  let save_pos = getpos(".")
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  call search('^[ ]\{0,2\}[a-zA-Z].*\({\|(\)$', 'bW')
endfun
function! GoToNextFunc()
  let save_pos = getpos(".")
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  call search('^[ ]\{0,2\}[#a-zA-Z].*\({\|(\)$', 'W')
endfun
map H [{
map L ]}
" map <silent> H :call GoToFuncStart()<CR>
" map <silent> L :call GoToNextFunc()<CR>
" map <silent> H 0?^[ ]\{0,5\}[a-zA-Z].*{$<CR>^:nohls<CR>
" map <silent> L $/^[ ]\{0,5\}[a-zA-Z].*{$<CR>^:nohls<CR>
augroup h_and_l
  autocmd!
  autocmd BufEnter *.vimrc nnoremap <buffer> H {
  autocmd BufEnter *.vimrc nnoremap <buffer> L }
augroup END

" -----------------------------------------------------------------------------------------
" Navigate panes
" -----------------------------------------------------------------------------------------
" Use '$ cat' to find the keys to map to
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
map ˙ <c-w>h
map ∆ <c-w>j
map ˚ <c-w>k
map ¬ <c-w>l
" -----------------------------------------------------------------------------------------

imap <c-z> <c-y>,

" Show colorscheme element under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <S-F10> :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<CR>
map <F8> :norm <c-a><CR>:w<BAR>:colo null<CR>
map <S-F8> :norm <c-x><CR>:w<BAR>:colo null<CR>

" }

" -----------------------------------------------------------------------------------------
" Default behavior overrides
" -----------------------------------------------------------------------------------------

" Don't copy overwritten text on visual paste
xnoremap p "_dP

" Move selected text up and down, or change indentation, with arrow keys
xnoremap <up> <esc>'<kdd'>pgv
xnoremap <down> <esc>'>jdd'<Pgv
xnoremap <left> <gv
xnoremap <right> >gv

" Easy normal mode command
xnoremap n :normal!<SPACE>

" Clear command box and search easily
nnoremap <silent> ,/ :nohlsearch<Bar>:echo<CR>
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Reselect text when changing indentation
" xnoremap < <gv
" xnoremap > >gv

" gf on any variable in the file that was imported (at least in ES6)
" Also, use gF by default, which allows jumping to line number e.g. filename.js:180
" nnoremap gf gF
" augroup gotofile
"   autocmd!
"   autocmd FileType javascript,javascript.jsx nnoremap <buffer> <silent> gf :norm "/yiw<CR>:norm gd<CR>:norm vi"gF<CR>:norm ggn<CR>:norm 0<CR>:nohls<CR>
" augroup END
" nmap gp :split<CR>gf

" Rename with search
nnoremap c* *Ncgn
nnoremap c# #NcgN

" augroup enterbehavior
"   autocmd!
"   autocmd BufWinEnter,WinEnter *{.js} nmap <buffer> <enter> :'<,'>norm<space>
" augroup END

" When doing commands, always scroll through history matching current text
cmap <c-p> <up>
cmap <c-n> <down>

" Pressing shift all the time is annoying
noremap ; :

" Case insensitive search (but still have case sensitive for :substitute
nnoremap / /\c
vnoremap / /\c
nnoremap ? ?\c
vnoremap ? ?\c

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Center screen and open folds when going through search results
" TODO: this can be slow and show a warning if no folds are found
" nnoremap <silent> n nzzzO
" nnoremap <silent> N NzzzO

" Don't skip wrapped lines
noremap j gj
noremap k gk

" Y should copy to end of line, not full line, same as D
noremap Y y$

" Unimpaired keys
nmap [[ :cprev<CR>
nmap ]] :cnext<CR>
nmap [q :cprev<CR>
nmap ]q :cnext<CR>
nmap [w :cpfile<CR>
nmap ]w :cnfile<CR>
nmap [e :colder<CR>
nmap ]e :cnewer<CR>
nmap [b :bprevious<CR>
nmap ]b :bnext<CR>
nmap [a :previous<CR>
nmap ]a :next<CR>
nmap [l :lprev<CR>
nmap ]l :lnext<CR>
nmap [f -k<CR>
nmap ]f -j<CR>
nmap [ow :set wrap<CR>
nmap ]ow :set nowrap<CR>
nmap [on :set number relativenumber<CR>
nmap ]on :set nonumber norelativenumber<CR>:GitGutterDisable<CR>
nmap ]n :next<CR>
nmap ]p :prev<CR>

" Maximize pane
nmap <leader>z <bar>_
nmap <leader><leader>z =
nmap <leader>= =

nmap <leader>; g;999g,

map <leader><leader>m :20messages<CR>

noremap gg gg0
noremap G G0

map gx :!open <cWORD><CR>

map <leader>' "ayiwologo<TAB>a

map <leader>e :e **/*
map <leader>b :buffer<SPACE>

" nnoremap d "_d
