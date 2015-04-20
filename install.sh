#!/bin/bash

prompted_to_delete=false

create_symlink() {
  if [ $prompted_to_delete=false ]; then
    if [ ! -L $2 ]; then
      if [ -f $2 ] || [ -d $2 ]; then 
        read -p "Non-symbolic file already exists, okay to delete? (y/n)" yn

        case $yn in
          [Yy]* ) ;;
          [Nn]* ) echo "Exiting..."; exit;;
      * ) echo "Please answer yes or no.";;
    esac

    prompted_to_delete=true
  fi
fi
fi

  if [ -L $2 ] || [ -f $2 ] || [ -d $2 ]; then
    echo "Removing symbolic link $2"
    rm -rf $2
  fi

  echo "Creating symbolic link $2"
  ln -s $1 $2
}


if [ ! -d ~/.oh-my-fish ]; then
  echo "Pulling down oh-my-fish"
  git clone https://github.com/bpinto/oh-my-fish ~/.oh-my-fish
fi

if [ ! -d ~/.vim/colors ]; then
  mkdir ~/.vim/colors
fi

create_symlink    ~/.dotfiles/.vimrc     ~/.vimrc
create_symlink    ~/.dotfiles/.vimrc     ~/.nvimrc
create_symlink    ~/.vim                 ~/.nvim
create_symlink    ~/.dotfiles/fish       ~/.config/fish
create_symlink    ~/.dotfiles/.elinks    ~/.elinks
create_symlink    ~/.dotfiles/.fishrc    ~/.fishrc                        
create_symlink    ~/.dotfiles/i3config   ~/.i3/config
create_symlink    ~/.dotfiles/sift.vim   ~/.vim/colors/sift.vim
create_symlink    ~/.dotfiles/badwolf.vim   ~/.vim/colors/badwolf.vim
create_symlink    ~/.dotfiles/.muttrc    ~/.muttrc
create_symlink    ~/.dotfiles/.Xdefaults ~/.Xdefaults
create_symlink    ~/.dotfiles/.surf ~/.surf
create_symlink    ~/.dotfiles/.offlineimaprc ~/.offlineimaprc
create_symlink    ~/.dotfiles/.signature ~/.signature
create_symlink    ~/.dotfiles/.tmux.conf ~/.tmux.conf
create_symlink    ~/.dotfiles/.Xmodmap ~/.Xmodmap

if [ ! -d ~/.vim/bundle ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

export TERM=xterm-256color
