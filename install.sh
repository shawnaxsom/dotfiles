#!/bin/bash

prompted_to_delete=false

install_cmake() {
  sudo add-apt-repository ppa:george-edison55/cmake-3.x
  sudo apt-get update
  sudo apt-get install cmake
}

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
  ln -s ~/.dotfiles/$1 $2
}


if [ ! -d ~/.oh-my-fish ]; then
  echo "Pulling down oh-my-fish"
  git clone http://github.com/oh-my-fish/oh-my-fish ~/.oh-my-fish
fi

if [ ! -d ~/.vim/colors ]; then
  mkdir ~/.vim/colors
fi

if [ ! -f  /usr/local/etc/profile.d/z.sh ]; then
  sudo wget https://raw.githubusercontent.com/rupa/z/master/z.sh -P /usr/local/etc/profile.d/
fi

mkdir -p ~/.vim/colors/

create_symlink    .vimrc     ~/.vimrc
create_symlink    .vimrc     ~/.nvimrc
create_symlink    UltiSnips     ~/.vim/UltiSnips
create_symlink    fish       ~/.config/fish
create_symlink    .elinks    ~/.elinks
create_symlink    i3config   ~/.i3/config
create_symlink    sift.vim   ~/.vim/colors/sift.vim
create_symlink    null.vim   ~/.vim/colors/null.vim
create_symlink    badwolf.vim   ~/.vim/colors/badwolf.vim
create_symlink    .muttrc    ~/.muttrc
create_symlink    .Xdefaults ~/.Xdefaults
create_symlink    .surf ~/.surf
create_symlink    .offlineimaprc ~/.offlineimaprc
create_symlink    .signature ~/.signature
create_symlink    .tmux.conf ~/.tmux.conf
create_symlink    .Xmodmap ~/.Xmodmap
create_symlink    .screenrc ~/.screenrc
create_symlink    .agignore ~/.agignore

if [ ! -d ~/.vim/bundle ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# if [ -f ~/.vim/bundle/YouCompleteMe/install.sh ]; then
#   sudo wget https://raw.githubusercontent.com/rupa/z/master/z.sh -P /usr/local/etc/profile.d/
#   install_cmake
#   sudo apt-get install python-dev
#   ~/.vim/bundle/YouCompleteMe/install.sh
#   cd ~/.vim/bundle/tern_for_vim && npm install
# fi
