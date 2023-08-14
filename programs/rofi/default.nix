{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };

  home.file = {
    ".config/networkmanager-dmenu/config.ini".source = ../../programs/rofi/networkmanager.ini;
    ".config/rofi/colors.rasi".source = ../../programs/rofi/colors.rasi;
    ".config/rofi/fonts.rasi".source = ../../programs/rofi/fonts.rasi;
    ".config/rofi/launcher.rasi".source = ../../programs/rofi/launcher.rasi;
  };
}
