
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
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

else
	env=~/.ssh/agent.env
	agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
	agent_start () {
		(umask 077; ssh-agent >| "$env")
		. "$env" >| /dev/null ; }
		agent_load_env
		# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
		agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
		if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
			agent_start
			ssh-add
		elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
			ssh-add
		fi
		unset env
fi
