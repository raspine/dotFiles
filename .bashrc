# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

xrandr --output HDMI3 --left-of HDMI1
#xrandr --output DP1 primary
xrandr --output DP1 --right-of HDMI1

eval $(keychain --eval -Q --agents ssh --quiet ~/.ssh/id_rsa_paneda ~/.ssh/id_rsa_gmail)

#{{{ Paths
TEMPLATE_BOOST_ROOT="/home/jsc/work/thirdpart/boost/boost_1_61_0"
BOOST_ROOT=$TEMPLATE_BOOST_ROOT
export TEMPLATE_BOOST_ROOT
export BOOST_ROOT
ZMQ_ROOT="/home/jsc/work/thirdpart/zeromq4-x"
export ZMQ_ROOT
export PATH="$PATH:~/.gem/ruby/2.2.0/bin"
export PATH="$PATH:/usr/lib/ccache/bin/"
#}}}

#{{{ Variables
export JAVA_HOME=/usr/lib/jvm/default
TEMPLATE_BOOST_ROOT="/home/jsc/work/thirdpart/boost/boost_1_61_0"
BOOST_ROOT=$TEMPLATE_BOOST_ROOT
export TEMPLATE_BOOST_ROOT
export BOOST_ROOT
ZMQ_ROOT="/home/jsc/work/thirdpart/zeromq4-x"
export ZMQ_ROOT
export CC="ccache gcc"
export CXX="ccache g++"
#}}}

source ~/homescripts/.sshrc

export BASH_ENV=~/.bashrc

