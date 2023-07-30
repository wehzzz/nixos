#!/bin/sh
pushd ~/.dotfiles
#nix build .#homeConfigurations.tinmar.activationPackage
#./result/activate
home-manager switch --flake . 
popd
