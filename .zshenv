# zmodload zsh/zprof && zprof

# system-wide environment settings for zsh
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# export PATH=/usr/local/bin:$PATH
# export PATH=/usr/local/sbin:$PATH

# ### Added by the Heroku Toolbelt
# export PATH=/usr/local/heroku/bin:$PATH

# export ELASTICPATH=/usr/local/Cellar/elasticsearch/2.2.0_1/libexec/bin
# export PATH=$ELASTICPATH:$PATH

# # go settings
# export GOPATH=$HOME/.go
# export PATH=$HOME/.go/bin:$HOME/Src/lang/go/bin:$PATH

# # anyenv
# alias brew="env PATH=${PATH/${HOME}\/\.anyenv\/envs\/pyenv\/shims:/} brew"

# if [ -d ${HOME}/.anyenv ] ; then
#     export PATH="$HOME/.anyenv/bin:$PATH"
#     eval "$(anyenv init - --no-rehash)"
# fi

# # ndenv
# # export NODE_PATH=$(ndenv root)

# # direnv
# eval "$(direnv hook zsh)"

# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PGDATA=/usr/local/var/postgres

# # for jncc
# export PATH=$HOME/.jncc:$PATH

# # for mecab
# export MECAB_PATH=/usr/local/Cellar/mecab/0.996/lib/libmecab.dylib

# # for postgresql
# export PATH=/usr/local/opt/postgresql@9.6/bin:$PATH

# # for mysql
# export PATH=/usr/local/opt/mysql@5.7/bin:$PATH

# # for Flutter
# export PATH=$HOME/Src/framework/flutter/flutter/bin:$PATH

# # for python
# export PYTHONSTARTUP=~/.pythonrc.py

# # for qt
# export PATH=/usr/local/opt/qt/bin:$PATH

# # for gh
# eval "$(gh completion -s zsh)"

# # for rust
# export PATH=$HOME/.cargo/bin:$PATH

# # for deno
# export PATH=$HOME/.deno/bin:$PATH

# export PATH=/usr/local/opt/bison/bin:$PATH
# export PATH=/usr/local/opt/bzip2/bin:$PATH
# export PATH=/usr/local/opt/libiconv/bin:$PATH

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/yuki/Src/other/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yuki/Src/other/google-cloud-sdk/path.zsh.inc'; fi
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/yuki/Src/other/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yuki/Src/other/google-cloud-sdk/completion.zsh.inc'; fi
