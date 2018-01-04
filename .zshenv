export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

### Added by the Heroku Toolbelt
export PATH=/usr/local/heroku/bin:$PATH

export ELASTICPATH=/usr/local/Cellar/elasticsearch/2.2.0_1/libexec/bin
export PATH=$ELASTICPATH:$PATH

# go settings
export GOPATH=$HOME/.go:$HOME/Src/lang/go
export PATH=$HOME/.go/bin:$HOME/Src/lang/go/bin:$PATH

# anyenv
alias brew="env PATH=${PATH/${HOME}\/\.anyenv\/envs\/pyenv\/shims:/} brew"

if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - --no-rehash)"
fi

# direnv
eval "$(direnv hook zsh)"

export ANDROID_HOME=/usr/local/opt/android-sdk
export PGDATA=/usr/local/var/postgres

# for jncc
export PATH=$HOME/.jncc:$PATH

# for mecab
export MECAB_PATH=/usr/local/Cellar/mecab/0.996/lib/libmecab.dylib

# for postgresql
export PATH=/usr/local/opt/postgresql@9.6/bin:$PATH
