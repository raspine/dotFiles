# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

xrandr --output HDMI3 --left-of DP1
xrandr --output HDMI1 --right-of DP1

source ~/homescripts/.sshrc

export BASH_ENV=~/.bashrc

