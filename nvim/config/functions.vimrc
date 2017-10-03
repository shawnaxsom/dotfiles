" { Functions
" Automatically create directories that don't exist if doing
" e.g. :e ./path/that/doesnt/exist/bar.js
function! <SID>AutoMkdir() abort
  let l:dir = expand('<afile>:p:h')
  let l:file = expand('<afile>:t')
  if !isdirectory(l:dir)
    call mkdir(l:dir, 'p')
    silent execute 'bw ' . l:dir . '/' . l:file
    silent execute 'e ' . l:dir . '/' . l:file
  endif
endfunction
augroup AutoMkdir
  autocmd!
  autocmd BufWritePre,FileWritePre,BufNewFile *
        \ call <SID>AutoMkdir()
augroup END

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
" nnoremap <silent> <C-A> :ZoomToggle<CR>


" MRU command-line completion
function! s:MRUComplete(ArgLead, CmdLine, CursorPos)
    return filter(copy(v:oldfiles), 'v:val =~ a:ArgLead')
endfunction

" MRU function
function! s:MRUDo(command, arg)
    if a:command == "tabedit"
        execute a:command . " " . a:arg . "|lcd %:p:h"
    else
        execute a:command . " " . a:arg
    endif
endfunction

" commands
command! -nargs=1 -complete=customlist,<sid>MRUComplete MRU call <sid>MRUDo('edit', <f-args>)
command! -nargs=1 -complete=customlist,<sid>MRUComplete MS call <sid>MRUDo('split', <f-args>)
command! -nargs=1 -complete=customlist,<sid>MRUComplete MV call <sid>MRUDo('vsplit', <f-args>)
command! -nargs=1 -complete=customlist,<sid>MRUComplete MT call <sid>MRUDo('tabedit', <f-args>)
" }
"
command! SC vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
