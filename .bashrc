# vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=5:nonu:nornu
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#{{{ Alias
# ls
alias ls='ls --color=auto'
alias ll="ls -lhF"
alias la="ls -Ad .*"

# get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## special commands
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'

## vim
alias svim='sudo vim'

## pacman
alias pacs='sudo pacman -S'
alias pacsyu='sudo pacman -Syu'

## git
alias gst='git status'
alias gco='git checkout'
alias gcob='git checkout branch'
alias gci='git commit'
alias glr='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias gla='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'
#}}}

#{{{ Functions
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
#}}}

#{{{ Paths
export PATH=$PATH:~/.gem/ruby/2.2.0/bin
#}}}

#{{{ Variables
export JAVA_HOME=/usr/lib/jvm/default
TEMPLATE_BOOST_ROOT="/home/jsc/work/thirdpart/boost/boost_1_59_0"
BOOST_ROOT=$TEMPLATE_BOOST_ROOT
export TEMPLATE_BOOST_ROOT
export BOOST_ROOT
ZMQ_ROOT="/home/jsc/work/thirdpart/zeromq4-x"
export ZMQ_ROOT
#}}}

#{{{ Bash settings
set -o vi
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
export TERM="xterm-256color"
#}}}

#eval $(keychain --eval -Q --agents ssh --quiet ~/.ssh/id_rsa_paneda ~/.ssh/id_rsa_gmail)

source /usr/share/git/completion/git-prompt.sh
PROMPT_COMMAND='__git_ps1 "\u \W" "\\\$ " " (%s)"'

export BASH_ENV=~/.bashrc

