#!/bin/sh

apm install --packages-file .atom/packages.txt

cat vscode/extensions.txt | xargs -n 1 code --install-extension
