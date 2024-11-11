#!/bin/bash

echo "Setting up NeoVim..."
echo "This configuration uses Packer to manage plugins. Make sure you have it installed before continuing."
echo "Press [Enter] to continue..."
while true; do
  read -s -n 1 input
  if [[ $input = '' ]]; then break; fi
done

HERE=$(dirname "${BASH_SOURCE[0]}")

command cp -r $HERE/nvim ~/.config/

echo "NeoVim all set up! You may want to alias 'vim' to 'nvim'"
echo "Don't forget to run `:PackerInstall` or `:PackerSync`/`:PackerCompile` from nvim"
