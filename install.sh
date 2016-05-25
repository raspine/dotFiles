#!/bin/bash
# sets up symbolic links for files in this directory

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

# home dir
clever_ln_s ~/homescripts/.bashrc ~/.bashrc
clever_ln_s ~/homescripts/.xinitrc ~/.xinitrc
clever_ln_s ~/homescripts/.Xmodmap ~/.Xmodmap
clever_ln_s ~/homescripts/.Xresources ~/.Xresources
clever_ln_s ~/homescripts/.xprofile ~/.xprofile

# vim
clever_ln_s ~/homescripts/.vimrc ~/.vim/vimrc
clever_ln_s ~/homescripts/ftplugin/java.vim ~/.vim/ftplugin/java.vim
clever_ln_s ~/homescripts/ftplugin/lua.vim ~/.vim/ftplugin/lua.vim
clever_ln_s ~/homescripts/ftplugin/c.vim ~/.vim/ftplugin/c.vim
clever_ln_s ~/homescripts/ftplugin/cpp.vim ~/.vim/ftplugin/cpp.vim
clever_ln_s ~/homescripts/ftplugin/sh.vim ~/.vim/ftplugin/sh.vim
clever_ln_s ~/homescripts/ftplugin/json.vim ~/.vim/ftplugin/json.vim

# vifm
clever_ln_s ~/homescripts/vifm/vifmrc ~/.vifm/vifmrc
clever_ln_s ~/homescripts/vifm/colors/astrall.vifm ~/.vifm/colors/astrall.vifm

