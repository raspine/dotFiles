# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu:ff=unix
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/dotFiles/.sshrc

# source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || \
    cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASH_ENV=~/.bashrc

