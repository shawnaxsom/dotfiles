#!/bin/bash

create_symlink() {
  if [[ -L "$2" ]]
  then
      echo "Removing symbolic link $2"
      rm ~/.vimrc
  fi
  ln -s $1 $2
}

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/fish ~/.config/fish
