{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    cycle = false;
  };

  home.file = {
    ".config/networkmanager-dmenu/config.ini".source = ../../programs/rofi/networkmanager.ini;
    ".config/rofi/colors.rasi".source = ../../programs/rofi/colors.rasi;
    ".config/rofi/fonts.rasi".source = ../../programs/rofi/fonts.rasi;
    ".config/rofi/launcher.rasi".source = ../../programs/rofi/launcher.rasi;
    ".config/rofi/powermenu.rasi".source = ../../programs/rofi/powermenu.rasi;
    ".config/rofi/network.rasi".source = ../../programs/rofi/network.rasi;
    ".config/rofi/bluetooth.rasi".source = ../../programs/rofi/bluetooth.rasi;
  };
}
