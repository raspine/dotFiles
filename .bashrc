# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu:ff=unix
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
#xrandr --output HDMI3 --left-of DP1
#xrandr --output HDMI1 --right-of DP1
#fi

source ~/homescripts/.sshrc

source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || \
    cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source /usr/share/xTIMEcomposer/Community_14.4.1/SetEnv

export BASH_ENV=~/.bashrc

