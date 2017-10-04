" { Colorscheme
set termguicolors
set background=dark

" " colorscheme beekai
" " colorscheme badwolf
" " colorscheme molokai
" " colorscheme Monokai
" " colorscheme void
" " colorscheme sift
" " colorscheme darkburn
" syntax on
" " colorscheme null
" " colorscheme predawn
" " colorscheme zenburn
" " colorscheme elflord
" colorscheme jellybeans
" colorscheme distinguished
" colorscheme vividchalk
" colorscheme gruvbox
" colorscheme dracula
" colorscheme solarized
" colorscheme darkblue
" colorscheme monokai
" colorscheme deus
" colorscheme flattr
" colorscheme onedark
" colorscheme pencil
colorscheme nova
" " } Colorscheme

" " { Highlights
" " These come after Colorscheme so they don't get overwritten
" "
" " { Background
highlight Normal guibg=#404040
" }
"
" { Comments
highlight Comment guifg=#999999
" }
"
" { Current line
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
highlight cursorLine term=bold cterm=bold guibg=#755545
" }
" { matchmaker
highlight Matchmaker guibg=#755545
" }
" { MatchTagAlways
highlight MatchTag guibg=#755545
" }
" { Column 80
" set colorcolumn=80
" highlight ColorColumn ctermbg=240 guibg=#303030
highlight ColorColumn guibg=#222222 guifg=#000000
" }

" { vim_current_word
" highlight CurrentWord term=reverse ctermfg=235 ctermbg=214 guifg=#282828 guibg=#fabd2f
" highlight CurrentWordTwins guibg=#587474 gui=underline  ctermbg=2 cterm=underline
" }
" { gitgutter
highlight GitGutterAdd          guibg=#505050
highlight GitGutterChange       guibg=#505050
highlight GitGutterDelete       guibg=#505050
" }
" { Numbers
hi LineNr guifg=#777777
" }
" " { Search
highlight IncSearch      cterm=reverse ctermfg=184 ctermbg=234 gui=reverse guifg=#f05050 guibg=#505050
highlight Search         ctermfg=0     ctermbg=220             gui=reverse guifg=#f08080 guibg=#505050
" " }
" }
