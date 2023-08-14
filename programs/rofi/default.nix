{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "alacritty";
  };

  home.file = {
    ".config/networkmanager-dmenu/config.ini".source = ../../programs/polybar/scripts/networkmanager.ini;
  };
}
