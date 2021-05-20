#!/bin/bash
# installs my personal scripts on a Arch host

is_package_installed() { #{{{
  #check if a package is already installed
  for PKG in $1; do
    pacman -Q $PKG &> /dev/null && return 0;
  done
  return 1
} #}}}

clever_ln_s() {
  if [ -f $2 ] && [ ! -L $2 ]; then
    # regular file, make backup
    mv $2 $2_bak
  elif [ -L $2 ]; then
    # already symlink
    return
  fi
  ln -s $1 $2
}

# needed packages
if ! is_package_installed "yay" ; then
  echo "plz install yaourt"
  return 1
fi
if ! is_package_installed "sshrc" ; then
  yaourt -S "sshrc"
fi

# home dir
clever_ln_s ~/homescripts/.bashrc ~/.bashrc
clever_ln_s ~/homescripts/.xinitrc ~/.xinitrc
clever_ln_s ~/homescripts/.Xmodmap ~/.Xmodmap
clever_ln_s ~/homescripts/.Xresources ~/.Xresources
clever_ln_s ~/homescripts/.xprofile ~/.xprofile
clever_ln_s ~/homescripts/.sshrc ~/.sshrc
clever_ln_s ~/homescripts/.profile ~/.profile
clever_ln_s ~/homescripts/.inputrc ~/.inputrc
clever_ln_s ~/homescripts/.gitconfig ~/.gitconfig

#cgdb
mkdir -p ~/cgdb
clever_ln_s ~/homescripts/.cgdb/cgdbrc ~/.cgdb/cgdbrc

#gdb-dashboard
mkdir -p ~/.gdbinit.d
clever_ln_s ~/homescripts/.gdbinit.d/init ~/.gdbinit.d/init

# vim
mkdir -p ~/.vim/ftplugin
clever_ln_s ~/homescripts/.vimrc ~/.vim/vimrc
clever_ln_s ~/homescripts/ftplugin/java.vim ~/.vim/after/ftplugin/java.vim
clever_ln_s ~/homescripts/ftplugin/lua.vim ~/.vim/after/ftplugin/lua.vim
clever_ln_s ~/homescripts/after/ftplugin/c.vim ~/.vim/after/ftplugin/c.vim
clever_ln_s ~/homescripts/ftplugin/cpp.vim ~/.vim/after/ftplugin/cpp.vim
clever_ln_s ~/homescripts/ftplugin/sh.vim ~/.vim/after/ftplugin/sh.vim
clever_ln_s ~/homescripts/ftplugin/json.vim ~/.vim/after/ftplugin/json.vim
clever_ln_s ~/homescripts/ftplugin/vim.vim ~/.vim/after/ftplugin/vim.vim
clever_ln_s ~/homescripts/ftplugin/help.vim ~/.vim/after/ftplugin/help.vim
clever_ln_s ~/homescripts/ftplugin/cmake.vim ~/.vim/after/ftplugin/cmake.vim
clever_ln_s ~/homescripts/ftplugin/javascript.vim ~/.vim/after/ftplugin/javascript.vim
clever_ln_s ~/homescripts/ftplugin/python.vim ~/.vim/after/ftplugin/python.vim
clever_ln_s ~/homescripts/ftplugin/matlab.vim ~/.vim/after/ftplugin/matlab.vim
clever_ln_s ~/homescripts/ftplugin/html.vim ~/.vim/after/ftplugin/html.vim
clever_ln_s ~/homescripts/ftplugin/typescript.vim ~/.vim/after/ftplugin/typescript.vim
clever_ln_s ~/homescripts/ftplugin/xc.vim ~/.vim/after/ftplugin/xc.vim

# vifm
mkdir -p ~/vifm/colors
clever_ln_s ~/homescripts/vifm/vifmrc ~/vifm/vifmrc
clever_ln_s ~/homescripts/vifm/colors/astrall.vifm ~/vifm/colors/astrall.vifm

