{ pkgs, lib, ... }:

let
    wallpaper = "/$HOME/.dotfiles/wallpaper/wallpaper_epita.jpg";
in
{
  programs.i3status.enable = true;
  xsession = {
    enable = true;

    windowManager = {
      i3 = {
        enable = true;

        extraConfig = ''
          workspace_auto_back_and_forth yes
          popup_during_fullscreen smart

	  for_window [class="^.*"] border pixel 1
          for_window [title="^.*"] border pixel 1

	  for_window [class="feh"] floating enable
	  for_window [class="Pavucontrol"] floating enable
        '';

        config = rec {
          modes = {
            resize = {
              Left  = "resize shrink width 10 px or 10 ppt";
              j     = "resize shrink width 10 px or 10 ppt";
              Right = "resize grow width 10 px or 10 ppt";
              m     = "resize grow width 10 px or 10 ppt";
              Up    = "resize shrink height 10 px or 10 ppt";
              l     = "resize shrink height 10 px or 10 ppt";
              Down  = "resize grow height 10 px or 10 ppt";
              k     = "resize grow height 10 px or 10 ppt";

              Escape = "mode default";
              Return = "mode default";
            };
          };

	  modifier = "Mod1";
          keybindings = lib.mkOptionDefault {
	    XF86AudioPlay          = "exec ${pkgs.playerctl}/bin/playerctl play";
            XF86AudioPause         = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
	    XF86AudioStop          = "exec ${pkgs.playerctl}/bin/playerctl stop";
            XF86AudioNext          = "exec ${pkgs.playerctl}/bin/playerctl next";
            XF86AudioPrev          = "exec ${pkgs.playerctl}/bin/playerctl previous";
            XF86AudioLowerVolume   = "exec amixer -q sset Master 5%-";
            XF86AudioRaiseVolume   = "exec amixer -q sset Master 5%+";
            XF86AudioMute          = "exec amixer -q sset Master toggle";

	    XF86MonBrightnessUp    = "exec light -A 5%";
            XF86MonBrightnessDown  = "exec light -U 5%";
            
	    "${modifier}+Return"        = "exec ${pkgs.alacritty}/bin/alacritty";
	   
	    "${modifier}+j" = "focus left";
            "${modifier}+k" = "focus down";
            "${modifier}+l" = "focus up";
            "${modifier}+m" = "focus right";

            "${modifier}+Shift+j" = "move left";
            "${modifier}+Shift+k" = "move down";
            "${modifier}+Shift+l" = "move up";
            "${modifier}+Shift+m" = "move right";

            "${modifier}+h" = "split h";
            "${modifier}+v" = "split v";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+ctrl+space" = "floating toggle";
            "${modifier}+Shift+a" = "kill";
            "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";
 
            "${modifier}+s" = "layout stacking";
            "${modifier}+z" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+r" = "mode resize";

	    # Screenshot
	    # Copy to clipboard
            "Print"                = "exec --no-startup-id flameshot gui -c";
	    # save in Pictures folder
	    "Ctrl+Print"           = "exec --no-startup-id flameshot gui -p \"/$HOME/Pictures/\"";	

	    "${modifier}+d"       = "exec --no-startup-id dmenu_run";
            #"${mod}+d"       = "exec ${rofi}/bin/rofi -show run";
          };

          startup = [
            {
              command = "~/.dotfiles/programs/polybar/scripts/launch.sh";
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

          bars = [
	  #{  	    
	    #statusCommand = "${pkgs.i3status}/bin/i3status";
            #position = "bottom";
	  #}
          ];

          gaps = {
	    top = 40;
            inner = 12;
            outer = 0;
            smartBorders = "on";
            smartGaps = false;
          };

          window = {
            hideEdgeBorders = "smart";
          };
        };
      };
    };
  };
}
