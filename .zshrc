# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="agnoster"
#ZSH_THEME="robbyrussell"
ZSH_THEME="blinks"
DEFAULT_USER=pgeoffroy

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(virtualenvwrapper git common-aliases tmux debian pass gpg-agent systemd colored-man extract history-substring-search systemadmin z)

export WORKON_HOME=~/.virtualenvs

source $ZSH/oh-my-zsh.sh

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa_home id_rsa_afeu

# User configuration

# Use cat > /dev/null, and then type desired keys to get their code
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "^[Oc" forward-word
bindkey "^[Od" backward-word
bindkey "^[OC" forward-word
bindkey "^[OD" backward-word

export PATH=$HOME/.local/bin:$HOME/.opam/system/bin:$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

if [ -d "$HOME/apps/nodejs/node/bin" ]; then
  PATH="$HOME/apps/nodejs/node/bin:$HOME/apps/nodejs/node/lib/node_modules/express-generator/bin:$PATH" ;
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source ~/dot-files/config.sh

alias tableau="rdesktop -g 1918x1040 -u ${TABLEAU_USER} -p \"${TABLEAU_MDP}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/dossiers-distants/tableau-share ${TABLEAU_HOST}"
alias tableauLow="rdesktop -g 1600x870 -u ${TABLEAU_USER} -p \"${TABLEAU_MDP}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST}"
alias tableauLaptop="rdesktop -g 1360x740 -u ${TABLEAU_USER} -p \"${TABLEAU_MDP}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST}"

alias tableau-dev="rdesktop -g 1918x1040 -u ${TABLEAU_USER_DEV} -p \"${TABLEAU_MDP_DEV}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST_DEV}"
alias tableauLow-dev="rdesktop -g 1600x870 -u ${TABLEAU_USER_DEV} -p \"${TABLEAU_MDP_DEV}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST_DEV}"
alias tableauLaptop-dev="rdesktop -g 1360x740 -u ${TABLEAU_USER_DEV} -p \"${TABLEAU_MDP_DEV}\" -D -N -P -z -r disk:csv=/home/pgeoffroy/tableau-share ${TABLEAU_HOST_DEV}"

alias git='LANG=en_US.UTF-8 git'

alias fax="ps fax"
alias faux="ps faux"

alias lrt="ls -lFcrth"

export LESSCHARSET=UTF-8

autoload -U compinit
compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

#autoload -U bashcompinit
#bashcompinit

#source ~/scripts/rsync-projet-auto-comp.sh

ssh() {
  [ -t 1 ] && echo -ne "\033]0;$@\007"
    LC_CTYPE="en_US.UTF-8" LC_ALL="" LANG="en_US.UTF-8" LC_MESSAGES="en_US.UTF-8" TERM="xterm" =ssh "$@"
}

if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]; then startx; fi

# OPAM configuration
. /home/pgeoffroy/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Added by Twgit makefile:
. /home/pgeoffroy/build/himedia-twgit/install/zsh_completion.sh


# source ~/.xsh

###-begin-ssh-tunnel-manager-completion-###
#
# ssh-tunnel-manager command completion script
#
# Installation: ssh-tunnel-manager completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: ssh-tunnel-manager completion > /usr/local/etc/bash_completion.d/ssh-tunnel-manager
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if complete &>/dev/null; then
  _ssh-tunnel-manager_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           ssh-tunnel-manager completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _ssh-tunnel-manager_completion ssh-tunnel-manager
elif compctl &>/dev/null; then
  _ssh-tunnel-manager_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       ssh-tunnel-manager completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _ssh-tunnel-manager_completion ssh-tunnel-manager
fi
###-end-ssh-tunnel-manager-completion-###
