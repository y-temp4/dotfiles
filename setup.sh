#!/bin/sh

PWD=`pwd`

ln -sf ${PWD}/.zshrc     ~/.zshrc
ln -sf ${PWD}/.zshenv    ~/.zshenv
ln -sf ${PWD}/.zprofile  ~/.zprofile
ln -sf ${PWD}/.gitconfig ~/.gitconfig
ln -sf ${PWD}/.vimrc     ~/.vimrc

[[ ! -d ~/.atom ]] && mkdir ~/.atom
ln -sf ${PWD}/.atom/config.cson   ~/.atom/config.cson
ln -sf ${PWD}/.atom/init.coffee   ~/.atom/init.coffee
ln -sf ${PWD}/.atom/keymap.cson   ~/.atom/keymap.cson
ln -sf ${PWD}/.atom/snippets.cson ~/.atom/snippets.cson
ln -sf ${PWD}/.atom/styles.less   ~/.atom/styles.less

[[ ! -d ~/Library/Application\ Support/Code ]] && mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ${PWD}/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

echo 'complete setting!'
