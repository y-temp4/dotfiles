export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

# Use emacs like keybind
bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# show virtualenv
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# 2 line prompt
PROMPT="$(virtualenv_info)%{${fg[green]}%}%n@%m %{${fg[blue]}[%D{%Y/%m/%d %T}]%{${reset_color}%} ${vcs_info_msg_0_}%~
\$ "

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{cyan}[%b] %f'
zstyle ':vcs_info:*' actionformats '%F{red}[%b|%a] %f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    PROMPT="$(virtualenv_info)%{${fg[green]}%}%n@%m%{${reset_color}%} ${vcs_info_msg_0_}%~
\$ "
    RPROMPT='[%D{%Y/%m/%d %H:%M}]'
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

alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lah'

alias f="open ."

alias vu='vagrant up'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vsh='vagrant ssh'
alias vst='vagrant status'

alias b='bundle'
alias be='bundle exec'

alias dc='docker-compose'

alias y='yarn'
alias ya='yarn add'
alias yad='yarn add -D'
alias yr='yarn remove'
alias yu='yarn run'

alias n='npm'
alias nr='npm run'
alias ni='npm i'
alias nid='npm i -D'
alias nu='npm uninstall'

alias s='subl .'
alias c='code .'

alias g='git'
alias gi='git'
alias gcu='git config user.name "y-temp4" && git config user.email "y.temp4@gmail.com"'
alias gs='git status --short --branch'
alias ga='git add'
alias gaa='git add --all'
alias gci='git commit'
alias d='git diff'
alias m='git checkout master'
alias o='git checkout'
alias ob='git checkout -b'
alias a='git add --all; git status --short'
alias cm='git_commit_with_arguments_message'

git_commit_with_arguments_message() {
  git commit --message "$*"
}

# https://github.com/cappyzawa/gh-ghq-cd
function glp() {
  selected="$(ghq list --full-path | fzf --reverse --preview "bat --color=always {1}/README.md")"
  [ -n "${selected}" ] || exit 1
  \cd ${selected}
  $SHELL
}

# ghq setting
alias glp='glp'
# alias glp='cd $(ghq list --full-path | fzf --reverse --preview "bat --color=always {1}/README.md")'
alias gqp='cd $(ghq list -p | peco)'
alias get='ghq get -p'

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

# For hub
function git(){hub "$@"}

# Use trash
alias rm='trash'

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

# for zsh-completions
# fpath=(~/.zsh/completions $fpath)


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/yuki/.anyenv/envs/ndenv/versions/v8.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/yuki/.anyenv/envs/ndenv/versions/v8.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/yuki/.anyenv/envs/ndenv/versions/v8.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/yuki/.anyenv/envs/ndenv/versions/v8.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
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
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

source ~/.yarn-completion/yarn-completion.plugin.zsh

# cd した時のhook
# iTerm のタブ名をpathに変更
# https://qiita.com/hasehiro0828/items/d8f1dd2a72c7999c9b76#iterm%E3%81%AE%E8%A8%AD%E5%AE%9A
echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}


# PATH

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

### Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

export ELASTICPATH=/usr/local/Cellar/elasticsearch/2.2.0_1/libexec/bin
export PATH=$ELASTICPATH:$PATH

# go settings
export GOPATH=$HOME/.go
export PATH=$HOME/.go/bin:$HOME/Src/lang/go/bin:$PATH

# anyenv
alias brew="env PATH=${PATH/${HOME}\/\.anyenv\/envs\/pyenv\/shims:/} brew"

if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - --no-rehash)"
fi

# ndenv
# export NODE_PATH=$(ndenv root)

# direnv
eval "$(direnv hook zsh)"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PGDATA=/usr/local/var/postgres

# for jncc
export PATH=$HOME/.jncc:$PATH

# for mecab
export MECAB_PATH=/usr/local/Cellar/mecab/0.996/lib/libmecab.dylib

# for postgresql
export PATH=/usr/local/opt/postgresql@9.6/bin:$PATH

# for mysql
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH

# for Flutter
export PATH=$HOME/Src/framework/flutter/flutter/bin:$PATH

# for python
export PYTHONSTARTUP=~/.pythonrc.py

# for qt
export PATH=/usr/local/opt/qt/bin:$PATH

# for gh
eval "$(gh completion -s zsh)"

# for deno
export PATH=$HOME/.deno/bin:$PATH

export PATH=/usr/local/opt/bison/bin:$PATH
export PATH=/usr/local/opt/bzip2/bin:$PATH
export PATH=/usr/local/opt/libiconv/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yuki/Src/other/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuki/Src/other/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/yuki/Src/other/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuki/Src/other/google-cloud-sdk/completion.zsh.inc'; fi
