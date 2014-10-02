# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export LC_ALL=""

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Informations git
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
function parse_git_status {
  noupdated=`git status --porcelain 2> /dev/null | grep -E "^ (M|D)" | wc -l`
  nocommitted=`git status --porcelain 2> /dev/null | grep -E "^(M|A|D|R|C)" | wc -l`
 
  if [[ $noupdated -gt 0 ]]; then echo -n "*"; fi
  if [[ $nocommitted -gt 0 ]]; then echo -n "+"; fi
}
 
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
PURPLE="\[\033[01;35m\]"
NC="\[\033[0m\]"
 
case $TERM in
    xterm*)
        TITLEBAR='\[\e]0;\u@\h: \w\a\]';
        ;;
    *)
        TITLEBAR="";
        ;;
esac
 
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    #PS1="\n\e[99B\e[0;44m\e[K == \H ==\e[0m\n \[\033[01;35m\]\t \[\033[01;31m\]\u\[\033[01;30m\]:\[\033[01;33m\]\w \[\033[01;31m\]# \[\033[00m\]"
     PS1="\n\e[99B\e[0;44m\e[K == \H ==\e[0m\n$PURPLE\$(date +%H:%M) $RED\u $YELLOW\w$BLUE\$(parse_git_branch)\$(parse_git_status) $RED# $NC"
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lhp'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias ssh_env="~/scripts/ssh_env"

export ALTERNATE_EDITOR="vim"
export EDITOR="vim"

alias afeu="ssh -L8000:10.1.84.1:80 -L1430:localhost:143 -L9930:localhost:993 -L8081:localhost:8081 -L3000:localhost:3000 -L50210:localhost:50210 pierre@${HOME_HOST}"

alias zf='/usr/local/zend/share/ZendFramework/bin/zf.sh'

STEAMLIBS=${HOME}/apps/steam-beta/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${STEAMLIBS}
export STEAMLIBS
export LD_LIBRARY_PATH

source ~/dot-files/config.sh

alias tableau="rdesktop -g 1600x880 -u pgeoffroy -D -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST}"

# Added by Twgit makefile:
. ~/workspace/himedia-twgit/install/bash_completion.sh

#. /home/pgeoffroy/workspace/powerline/bindings/bash/powerline.sh
. /home/pgeoffroy/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
. ~/scripts/rsync-projet-auto-comp.sh
