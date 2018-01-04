export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

# Use emacs like keybind
bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 2 line prompt
PROMPT="%{${fg[green]}%}%n@%m %{${fg[blue]}[%D{%Y/%m/%d %T}]%{${reset_color}%} ${vcs_info_msg_0_}%~
%# "

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{cyan}[%b] %f'
zstyle ':vcs_info:*' actionformats '%F{red}[%b|%a] %f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    PROMPT="%{${fg[green]}%}%n@%m%{${reset_color}%} ${vcs_info_msg_0_}%~
%# "
}
add-zsh-hook precmd _update_vcs_info_msg

autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# Auto compolete

# Use autocomplete
autoload -Uz compinit
compinit

zstyle ':completion:*:default' menu select=2

# Match lowercase letters with uppercase letters
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Do not complete the current dir after ../
zstyle ':completion:*' ignore-parents parent pwd ..

# Complete commands after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Process name completion of ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# Option
# Enable to show japanese filename
setopt print_eight_bit

# Disabel beep
setopt no_beep

# Disable flow control
setopt no_flow_control

# Not to exit with Ctrl+D
setopt ignore_eof

# Treat after '#' as a comment
setopt interactive_comments

# cd only dir name
setopt auto_cd
function chpwd() { ls -l }

# Auto pushd after cd
setopt auto_pushd
# Not to add duplicate dir
setopt pushd_ignore_dups

# Sharing history between zsh that started at the same time
setopt share_history

# Do not leave the same command in the history
setopt hist_ignore_all_dups

# Command lines beginning with a space are not left in the history
setopt hist_ignore_space

# Delete extra space when saved in history
setopt hist_reduce_blanks

# Use advanced wildcard expansion
setopt extended_glob

setopt nonomatch

########################################
# Alias

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias f="open ."

alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vsh='vagrant ssh'
alias vst='vagrant status'

alias b='bundle'
alias be='bundle exec'

alias s='subl .'
alias a='atom .'

alias g='git'
alias gi='git'
alias gcu='git config user.name "y-temp4" && git config user.email "y.temp4@gmail.com"'
alias gs='git status --short --branch'
alias ga='git add'
alias gaa='git add --all'
alias d='git diff'
alias m='git checkout master'

# ghq setting
alias glp='cd $(ghq list -p | peco)'
alias gqp='cd $(ghq list -p | peco)'

# gh-page setting
alias ghp='gh-open $(ghq list -p | peco)'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias ...='../../'
alias ....='../../../'

# Enable alias with command after sudo
alias sudo='sudo '

alias grep='grep --color'

alias -g L='| less'
alias -g G='| grep'

# Use rmtrash
alias rm='rmtrash'

# less with color
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# Copy standard output to clipboard
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# Setting for OS 
case ${OSTYPE} in
    darwin*)
        # For Mac
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        # For Linux
        alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:

# for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Do not register duplicate paths
typeset -U path PATH

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# peco find directory
function peco-find() {
  local current_buffer=$BUFFER
  local search_root=""
  local file_path=""

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    search_root=`git rev-parse --show-toplevel`
  else
    search_root=`pwd`
  fi
  file_path="$(find ${search_root} -maxdepth 5 | peco)"
  BUFFER="${current_buffer} ${file_path}"
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-find

# bind keys
# bindkey '^f' peco-find
bindkey '^x' peco-find
