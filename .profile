
eval $(keychain --eval --agents ssh --quiet ~/.ssh/id_rsa_paneda ~/.ssh/id_rsa_gmail)

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

