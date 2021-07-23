#!/bin/bash

# Source global definitions.
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

PATH="$PATH:/Users/pabs//bin"
PATH="$PATH:/Users/pabs/.local/bin"
PATH="$PATH:/Users/pabs/Library/Python/3.9/bin"

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)
PS1="\\[\$red\\][\\u@\\h]\\[\$reset\\]\\[\$green\\][\\w]\\n\\[\$reset\\] \$ "

shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=100000
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

_hosts(){
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(cat ~/inventory/hosts)" -- $cur) )
}

complete -F _hosts ssh

alias load='source ~/.bashrc'
alias lload='vim ~/.bashrc'
alias tmux='tmux -L /tmp'
alias parallel='parallel --will-cite'
alias ll='ls -l'
alias T='sort | unic -c | sort -nr'
alias xx='exit'
alias g='git'

llg(){ ls | grep ".*$1" --color=never; }

email(){
    [[ $# -ne 3 ]] && echo "Usage: email <subject> <body> <to>" && return
    subject=$1
    body=$2
    to=$3
    echo -e "$2" | mail -s "$1" $3
}

see(){
    [[ $# -eq 1 ]] && local regex=\*$1\*
    find . -name "$regex"
}

sleepuntil(){
    while ( $@ ); do
        sleep 10;
    done
}
