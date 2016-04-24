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
