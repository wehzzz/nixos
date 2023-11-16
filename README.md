# nixos
My nixos configuration
# INSTALLATION
## Clone
```
git clone https://github.com/wehzzz/nixos.git
mkdir ~/.dotfiles
mv nixos/* ~/.dotfiles
```
and then make .dotfiles directory a git repository

## Switch to unstable
```
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nixos-rebuild switch --upgrade
```

## Install home-manager
```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
nix-shell '<home-manager>' -A install
sudo nixos-rebuild switch
```
## Launch flake
Finally you just have to execute the following command in order to build your config
```
sudo ./apply-system.sh
./apply-user.sh
```
