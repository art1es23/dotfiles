#!/bin/bash

echo "Setup configuration is started.."
pwd

# Install Nix package manager
sh <(curl -L https://nixos.org/nix/install)
# After need to approve all prompts

cd ~
# Load the dotfiles from github repo
git clone https://github.com/art1es23/dotfiles.git
# Open the nix configuration folder
cd ~/dotfiles/nix-darwin
# Init the nix-darwin flake if it's not created before
# nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
# Build nix flake configuration
# nix build .#darwinConfigurations.qmpwwsd.system --impure
# Run the nix-darwin flake
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#qmpwwsd --impure

# Run home-manager to update configuration
home-manager switch --flake .#qmpwwsd@qmpwwsd --impure

echo "Setup configuration is finished"
