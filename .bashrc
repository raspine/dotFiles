# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

xrandr --output HDMI3 --left-of HDMI1
#xrandr --output DP1 primary
xrandr --output DP1 --right-of HDMI1

source ~/homescripts/.sshrc

export BASH_ENV=~/.bashrc

