#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

export JAVA_HOME=/usr/lib/jvm/default

TEMPLATE_BOOST_ROOT="/home/jsc/work/thirdpart/boost/boost_1_59_0"
BOOST_ROOT=$TEMPLATE_BOOST_ROOT
export TEMPLATE_BOOST_ROOT
export BOOST_ROOT
ZMQ_ROOT="/home/jsc/work/thirdpart/zeromq4-x"
export ZMQ_ROOT
export PATH=$PATH:~/.gem/ruby/2.2.0/bin

set -o vi

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

export TERM="xterm-256color"

eval $(keychain --eval -Q --agents ssh --quiet ~/.ssh/id_rsa_paneda ~/.ssh/id_rsa_gmail ~/.ssh/id_rsa_paneda_mirror)

ssh -L localhost:7000:localhost:7000 -Nf paneda@pacman.paneda.tech

#export GITAWAREPROMPT=~/.bash/git-aware-prompt
#source "${GITAWAREPROMPT}/main.sh"
#export PS1="\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtwht\]\$git_branch\[$txtred\]\$git_dirty\[$txtwht\]\$ "
source /usr/share/git/completion/git-prompt.sh
#PS1='\u \W$(__git_ps1 " [%s $(get_sha)] ")\$ '
#PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

txtblk="$(tput setaf 0 2>/dev/null || echo '\e[0;30m')"  # Black
txtred="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"  # Red
txtgrn="$(tput setaf 2 2>/dev/null || echo '\e[0;32m')"  # Green
txtylw="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"  # Yellow
txtblu="$(tput setaf 4 2>/dev/null || echo '\e[0;34m')"  # Blue
txtpur="$(tput setaf 5 2>/dev/null || echo '\e[0;35m')"  # Purple
txtcyn="$(tput setaf 6 2>/dev/null || echo '\e[0;36m')"  # Cyan
txtwht="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"  # White

PROMPT_COMMAND='__git_ps1 "\u \W" "\\\$ " " (%s)"'

export BASH_ENV=~/.bashrc

# cd and ls in one
cl() {
    dir=$1
    if [[ -z "$dir" ]]; then
        dir=$HOME
    fi
    if [[ -d "$dir" ]]; then
        cd "$dir"
        ls -hall --color=auto
    else
        echo "bash: cl: '$dir': Directory not found"
    fi
}

shopt -s extglob
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

