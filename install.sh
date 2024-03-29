#!/bin/bash
# installs my personal scripts on a Arch host

is_package_installed() { #{{{
  #check if a package is already installed
  for PKG in $1; do
    pacman -Q $PKG &> /dev/null && return 0;
  done
  return 1
} #}}}

install_packages() { #{{{
  if is_package_installed "pamac" ; then
    aurInstaller="sudo pamac install"
  elif is_package_installed "yay" ; then
    aurInstaller="yay -S"
  else
      echo "plz install yay"
      return 1
  fi

  $aurInstaller sshrc ttf-dejavu-sans-mono-powerline-git vim-plug
  pacman -S powerline wget
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

while true; do
read -p "Install packages? (y/n) " yn
case $yn in 
  [yY] ) echo install_packages;
    break;;
  [nN] ) echo skipping package install;
    break;;
  * ) echo invalid response;;
esac
done

# home dir
clever_ln_s ~/dotFiles/.bashrc ~/.bashrc
clever_ln_s ~/dotFiles/.bash_profile ~/.bash_profile
clever_ln_s ~/dotFiles/.xinitrc ~/.xinitrc
clever_ln_s ~/dotFiles/.Xmodmap ~/.Xmodmap
clever_ln_s ~/dotFiles/.Xresources ~/.Xresources
clever_ln_s ~/dotFiles/.xprofile ~/.xprofile
clever_ln_s ~/dotFiles/.xsessionrc ~/.xsessionrc
clever_ln_s ~/dotFiles/.sshrc ~/.sshrc
clever_ln_s ~/dotFiles/.inputrc ~/.inputrc
clever_ln_s ~/dotFiles/.gitconfig ~/.gitconfig
clever_ln_s ~/dotFiles/.ripgreprc ~/.ripgreprc
clever_ln_s ~/dotFiles/.tmux.conf ~/.tmux.conf

# plasma
cp ~/dotFiles/ssh-add.desktop ~/.config/autostart
cp ~/dotFiles/askpass.sh ~/.config/plasma-workspace/env

# systemd
mkdir -p ~/.config/systemd/user && cp ~/dotFiles/ssh_agent.service ~/.config/systemd/user
systemctl --user enable ssh_agent.service
# use: systemctl --user daemon-reload and systemctl --user show-environment
mkdir -p ~/.config/environment.d && cp ~/dotFiles/envvars.conf ~/.config/environment.d

#cgdb
mkdir -p ~/.cgdb && clever_ln_s ~/dotFiles/.cgdb/cgdbrc ~/.cgdb/cgdbrc

#gdb-dashboard
mkdir -p ~/.gdbinit.d && clever_ln_s ~/dotFiles/.gdbinit.d/init ~/.gdbinit.d/init
[[ ! -f ~/.gdbinit ]] && wget -P ~ https://git.io/.gdbinit

# vim
mkdir -p ~/.vim/after/ftplugin/
clever_ln_s ~/dotFiles/.vimrc ~/.vim/vimrc
clever_ln_s ~/dotFiles/ftplugin/java.vim ~/.vim/after/ftplugin/java.vim
clever_ln_s ~/dotFiles/ftplugin/lua.vim ~/.vim/after/ftplugin/lua.vim
clever_ln_s ~/dotFiles/after/ftplugin/c.vim ~/.vim/after/ftplugin/c.vim
clever_ln_s ~/dotFiles/ftplugin/cpp.vim ~/.vim/after/ftplugin/cpp.vim
clever_ln_s ~/dotFiles/ftplugin/sh.vim ~/.vim/after/ftplugin/sh.vim
clever_ln_s ~/dotFiles/ftplugin/json.vim ~/.vim/after/ftplugin/json.vim
clever_ln_s ~/dotFiles/ftplugin/vim.vim ~/.vim/after/ftplugin/vim.vim
clever_ln_s ~/dotFiles/ftplugin/help.vim ~/.vim/after/ftplugin/help.vim
clever_ln_s ~/dotFiles/ftplugin/cmake.vim ~/.vim/after/ftplugin/cmake.vim
clever_ln_s ~/dotFiles/ftplugin/javascript.vim ~/.vim/after/ftplugin/javascript.vim
clever_ln_s ~/dotFiles/ftplugin/python.vim ~/.vim/after/ftplugin/python.vim
clever_ln_s ~/dotFiles/ftplugin/matlab.vim ~/.vim/after/ftplugin/matlab.vim
clever_ln_s ~/dotFiles/ftplugin/html.vim ~/.vim/after/ftplugin/html.vim
clever_ln_s ~/dotFiles/ftplugin/typescript.vim ~/.vim/after/ftplugin/typescript.vim
clever_ln_s ~/dotFiles/ftplugin/xc.vim ~/.vim/after/ftplugin/xc.vim

