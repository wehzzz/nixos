{ config, pkgs, ... }:

{
 
  imports = [
    ../../programs
  ]; 

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tinmar";
  home.homeDirectory = "/home/tinmar";
  home.stateVersion = "23.05"; # Do not change value.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #System command
    htop
    wget
    neofetch
    feh
    binutils
    file
    tree
    zip
    unzip
    patchelf
    pciutils
    flameshot
    unrar
    findutils
    p7zip

    #command line env
    zsh
    oh-my-zsh

    #dev
    git
    vim
    git
    gnupg
    pinentry_qt
    git_crypt
    gcc
    gnumake
    vscode
    docker-compose

    #desktop
    firefox
    rofi
    polybar
    i3
    geany
    discord
    picom
    
    #sound
    pavucontrol
    playerctl    
 
    #misc
    nerdfonts
    roboto
    ];

  fonts.fontconfig.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "0pml1x6pzmdp6h19257by1x5b25smi2y60l1z40mi58aimdp59ss";
        }; }
      );
    })
  ];   

  programs = {
    home-manager.enable = true;
  }; 

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tinmar/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
