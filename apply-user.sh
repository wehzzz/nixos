#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/tinmar/home.nix
popd
