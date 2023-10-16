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
" colorscheme dracula
" colorscheme solarized
" colorscheme darkblue
" colorscheme monokai
" colorscheme deus
" colorscheme flattr
" colorscheme onedark
" colorscheme pencil
" colorscheme candyman
" colorscheme 3dglasses
" colorscheme paramount
" colorscheme zenburn
" colorscheme oceandeep
" colorscheme winter
" colorscheme nova
" colorscheme kiss
" colorscheme dusk
" colorscheme flattr
colorscheme gruvbox
" " } Colorscheme

" " { Highlights
" " These come after Colorscheme so they don't get overwritten
" "
" " { Background
" highlight Normal guibg=#404040
" }
"
" { Comments
" highlight Comment guifg=#999999
" }
" { Matching Parens
" highlight MatchParen guibg=#a0a080 guifg=#fff000
" }
"
" { Current line
" augroup CursorLine
"     autocmd!
"     autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"     autocmd WinLeave * setlocal nocursorline
" augroup END
highlight cursorLine term=bold cterm=bold guifg=#ffffff guibg=#254585
" }
" { Visual Selection
" highlight Visual term=bold cterm=bold guibg=#2555a5
" }
" { matchmaker
highlight Matchmaker guibg=#c5c080 guifg=#000000
" }
" { MatchTagAlways
" highlight MatchTag guibg=#656565
" }
" { Column 80
" set colorcolumn=80
" highlight ColorColumn ctermbg=240 guibg=#303030
" highlight ColorColumn guibg=#222222 guifg=#000000
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

hi DiffAdd      guibg=#5af540 guifg=#05293d
hi DiffDelete   guibg=#aa0500 guifg=#a5293d
hi DiffChange   guibg=#5aa5f0 guifg=#05293d
hi DiffText     guibg=#faa5f0 guifg=#f5293d

" { vim-diminactive
hi ColorColumn guifg=#444444 guibg=#000000
" }
