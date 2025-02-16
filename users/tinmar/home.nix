{ config, pkgs, lib, ... }:
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
    man-pages
    man-pages-posix
    gdb
    gimp

#System command
    bc
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
    qemu
    #pikaboot
    openssl.dev
    #command line env

    #dev
    cmake
    nlohmann_json
    jansson
    vim
    gnupg
    pinentry
    gcc
    gnumake
    docker-compose
    inxi
    nodejs_20
    yarn
    pngpp
    gpp

    #desktop
    firefox
    rofi-power-menu
    rofi-systemd
    rofi-bluetooth
    rofi-pulse-select
    networkmanager_dmenu  
    xfce.thunar
    killall 
    geany
    discord
    picom
    dmenu
    #sound
    pavucontrol
    playerctl    
 
    #misc
    roboto
    
    #acdc
    clang-tools
    dash
    shellcheck
    perl
    graphviz
    python3
    python311Packages.pip
    poetry
    jetbrains.pycharm-community
    docker
    vlc
    maven
    postgresql
    jetbrains.idea-ultimate
    jdk21
    slack
    quarkus
    helix
    ];
  
  nixpkgs.overlays = let
    files = {
      "jdk-21_linux-aarch64_bin.tar.gz"            = ../../../Downloads/java/jdk-21_linux-aarch64_bin.tar.gz;
    };
  in [
    (self: super: {
      requireFile = args @ {name, url, sha1 ? null, sha256 ? null}:
        if files?${name} then
          self.stdenvNoCC.mkDerivation {
            inherit name;
            outputHashMode = "flat";
            outputHashAlgo = if sha256 != null then "sha256" else "sha1";
            outputHash     = if sha256 != null then  sha256  else  sha1 ;
            buildCommand   = "cp ${files.${name}} $out";
          }
        else
          super.requireFile args;
    })

    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "1f7xqzi3djxqpw1j0cjqvxfq05gdl0v373rqbf3gk8b5mbpcj7i8";
        }; }
      );
    })   
  ];

  fonts.fontconfig.enable = true;
  
  programs = {
    home-manager.enable = true;
    vscode.enable = true;
  }; 

  systemd.user.services.polybar = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service.Environment = lib.mkForce ""; # to override the package's default configuration
    Service.PassEnvironment = "PATH"; # so that the entire PATH is passed to this service (alternatively, you can import the entire PATH to systemd at startup, which I'm not sure is recommended
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
