source $HOME/.config/nvim/config/options.vimrc
source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/buffers.vimrc
source $HOME/.config/nvim/config/languages.vimrc
source $HOME/.config/nvim/config/marks.vimrc
source $HOME/.config/nvim/config/mappings.vimrc
source $HOME/.config/nvim/config/functions.vimrc
source $HOME/.config/nvim/config/abbreviations.vimrc
source $HOME/.config/nvim/config/colorscheme.vimrc
source $HOME/.config/nvim/config/textobjects.vimrc


" { .vimrc / init.vim
augroup config
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd BufWritePost init.vim source % | setlocal foldmethod=marker
  autocmd BufWritePost init.vim set modeline | doautocmd BufRead
  " autocmd BufReadPost init.vim normal `.
augroup END
" }

