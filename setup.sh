#!/bin/bash

echo "Setup configuration is started.."

pwd
curl https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.config/alacritty/themes/themes/coolnight.toml --output ~/dotfiles/alacritty/themes/coolnight.toml

echo "Setup configuration is finished"
