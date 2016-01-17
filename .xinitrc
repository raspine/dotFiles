
userresources=$HOME/.Xresources

if [ -f $userresources ]; then
xrdb -merge $userresources
fi
