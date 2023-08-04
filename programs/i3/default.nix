{ pkgs, ... }:

let
    wallpaper = "../../wallpaper/wallpaper.jpg";
in
  xsession = {
    enable = true;

    windowManager = {
      i3 = {
        enable = true;

        extraConfig = ''
          workspace_auto_back_and_forth yes
          popup_during_fullscreen smart
        '';

        config = {
          modes = {
            resize = {
              Left  = "resize shrink width 10 px or 10 ppt";
              h     = "resize shrink width 10 px or 10 ppt";
              Right = "resize grow width 10 px or 10 ppt";
              l     = "resize grow width 10 px or 10 ppt";
              Up    = "resize shrink height 10 px or 10 ppt";
              k     = "resize shrink height 10 px or 10 ppt";
              Down  = "resize grow height 10 px or 10 ppt";
              j     = "resize grow height 10 px or 10 ppt";

              Escape = "mode default";
              Return = "mode default";
            };
          };

          keybindings = let mod = "Mod1"; in with pkgs; {
            XF86AudioPause         = "exec ${playerctl}/bin/playerctl pause";
            XF86AudioNext          = "exec ${playerctl}/bin/playerctl next";
            XF86AudioPrev          = "exec ${playerctl}/bin/playerctl previous";
            XF86AudioLowerVolume   = "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 -5%";
            XF86AudioRaiseVolume   = "exec ${pulseaudioFull}/bin/pactl set-sink-volume 0 +5%";
            XF86AudioMute          = "exec ${pulseaudioFull}/bin/pactl set-sink-mute 0 toggle";

            "${mod}+Return"        = "exec ${alacritty}/bin/alacritty";
            "${mod}+Shift+less"    = "exec xbacklight -dec 33%";
            "${mod}+Shift+greater" = "exec xbacklight -inc 33%";
	    
	    # Screenshot
	    # Copy to clipboard
            "Print"                = "exec --no-startup-id flameshot gui -c";
	    # save in Pictures folder
	    "Ctrl+Print"           = "exec --no-startup-id flameshot gui -p \"/$HOME/Pictures/\"";	

	    "${mod}+d"       = "exec --no-startup-id dmenu_run";
            #"${mod}+d"       = "exec ${rofi}/bin/rofi -show run";
          };

          startup = [
            {
              command = "systemctl --user restart polybar";
              always = true;
              notification = false;
            }
            {
              command = "${pkgs.networkmanagerapplet}/bin/nm-applet";
              always = true;
            }
	    {
              command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}";
              always = true;
              notification = false;
      	    }
	    {
              command = "${pkgs.discord}/bin/Discord --enable-gpu-rasterization";
              notification = false;
            }	
          ];

          bars = [];

          fonts = ["DejaVu Sans Mono 8"];

          gaps = {
            inner = 12;
            outer = 0;
            smartBorders = "on";
            smartGaps = true;
          };

          window = {
            hideEdgeBorders = "smart";
          };
        };
      };
    };
  };
}
