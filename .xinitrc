
userresources=$HOME/.Xresources

if [ -f $userresources ]; then
xrdb -merge $userresources
fi

keychain ~/.ssh/id_rsa_paneda ~/.ssh/id_rsa_gmail
[ -f ~/.keychain/$HOSTNAME-sh ] && . ~/.keychain/$HOSTNAME-sh 2>/dev/null
[ -f ~/.keychain/$HOSTNAME-sh-gpg ] && . ~/.keychain/$HOSTNAME-sh-gpg 2>/dev/null
