" source $HOME/.config/nvim/autoload/plug.vim

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
source $HOME/.config/nvim/config/notes.vimrc
source $HOME/.config/nvim/config/files.vimrc
source $HOME/.config/nvim/config/refactorings.vimrc
source $HOME/.config/nvim/config/packagejson.vimrc
source $HOME/.config/nvim/config/secrets.vimrc

" luado require "nvim-treesitter.configs".setup {
"       \  highlight = {
"       \    enable = true,
"       \  },
"       \}

" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "all",     -- one of "all", "language", or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = { "c", "rust" },  -- list of language that will be disabled
"   },
" }

augroup config
  autocmd!
  autocmd BufWritePost init.vim,*.vimrc source %
  autocmd BufWritePost init.vim,*.vimrc set modeline | doautocmd BufRead
  " autocmd BufReadPost init.vim normal `.
augroup END
