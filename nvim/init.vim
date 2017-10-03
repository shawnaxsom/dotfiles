source $HOME/.config/nvim/config/options.vimrc
source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/grep.vimrc
source $HOME/.config/nvim/config/colorscheme.vimrc
source $HOME/.config/nvim/config/statusline.vimrc
source $HOME/.config/nvim/config/languages.vimrc
source $HOME/.config/nvim/config/marks.vimrc
source $HOME/.config/nvim/config/functions.vimrc
source $HOME/.config/nvim/config/mappings.vimrc
source $HOME/.config/nvim/config/windows.vimrc
source $HOME/.config/nvim/config/buffers.vimrc
source $HOME/.config/nvim/config/terminal.vimrc
source $HOME/.config/nvim/config/abbreviations.vimrc
source $HOME/.config/nvim/config/textobjects.vimrc
source $HOME/.config/nvim/config/lint.vimrc

" Mappings to edit certain files
source $HOME/.config/nvim/config/notes.vimrc
source $HOME/.config/nvim/config/edits.vimrc

augroup config
  autocmd!
  autocmd BufWritePost init.vim,*.vimrc source %
  autocmd BufWritePost init.vim,*.vimrc set modeline | doautocmd BufRead
  " autocmd BufReadPost init.vim normal `.
augroup END

