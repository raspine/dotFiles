
eval $(keychain --eval --agents ssh --quiet ~/.ssh/id_rsa_paneda)
# eval $(keychain --eval --agents ssh --quiet `find ~/.ssh -type f \( -iname "id_*" ! -iname "*.pub" \)`)
export PATH="$PATH:~/.gem/ruby/2.2.0/bin"
export PATH="$PATH:/usr/lib/ccache/bin/"

export JAVA_HOME=/usr/lib/jvm/default
TEMPLATE_BOOST_ROOT="/home/jsc/work/thirdpart/boost/boost_1_66_0"
BOOST_ROOT=$TEMPLATE_BOOST_ROOT
export TEMPLATE_BOOST_ROOT
export BOOST_ROOT
export CC="ccache clang"
export CXX="ccache clang++"

