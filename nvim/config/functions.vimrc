" { Functions
" Automatically create directories that don't exist if doing
" e.g. :e ./path/that/doesnt/exist/bar.js
" NOTE: Removed for now, as often improper commands could lead to extra directories
" function! <SID>AutoMkdir() abort
"   let l:dir = expand('<afile>:p:h')
"   let l:file = expand('<afile>:t')
"   if !isdirectory(l:dir)
"     call mkdir(l:dir, 'p')
"     silent execute 'bw ' . l:dir . '/' . l:file
"     silent execute 'e ' . l:dir . '/' . l:file
"   endif
" endfunction
" augroup AutoMkdir
"   autocmd!
"   autocmd BufWritePre,FileWritePre,BufNewFile *
"         \ call <SID>AutoMkdir()
" augroup END

function! StripTrailingWhitespace ()
  " Don't strip on these filetypes
  if &ft =~ 'sql'
    return
  endif
  %s/\s\+$//e
endfunction
augroup stripwhitespace
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespace()
augroup END

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" " Keep location of file when reopening
" augroup keeplocation
"   autocmd!
"   autocmd BufReadPost *
"   \   if line("'\"") > 0 && line("'\"") <= line("$") |
"   \       exe 'normal! g`"zvzz' |
"   \   endif
" augroup END

" Prevent browsing in Fugitive from creating a trail of temp file buffers
augroup fugitive
  autocmd! BufReadPost fugitive://*
  autocmd BufReadPost fugitive://*
    \ set bufhidden=delete
augroup END

" Zoom / Restore window.
function! s:KeepZoomed() abort
    if exists('t:zoomed') && t:zoomed
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    else
        execute "GoldenRatioResize"
    endif
endfunction
command! KeepZoomed call s:KeepZoomed()
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0

    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
function! s:ZoomDisable() abort
    let t:zoomed = 0
endfunction
command! ZoomDisable call s:ZoomDisable()
function! s:Zoom() abort
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
endfunction
command! Zoom call s:Zoom()
" autocmd BufWinEnter,WinEnter * KeepZoomed  " TODO: this gets errors on Keep/Reject in Quickfix window
" nmap <buffer> <enter> :ZoomDisable<CR>
nnoremap <silent> <leader><leader>z :ZoomToggle<CR>
"
command! SC vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile


" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)
