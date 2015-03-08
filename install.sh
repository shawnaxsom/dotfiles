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

create_symlink    ~/.dotfiles/.vimrc     ~/.vimrc
create_symlink    ~/.dotfiles/fish       ~/.config/fish
create_symlink    ~/.dotfiles/.fishrc    ~/.fishrc                        
create_symlink    ~/.dotfiles/i3config   ~/.i3/config
create_symlink    ~/.dotfiles/sift.vim   ~/.vim/colors/sift.vim

