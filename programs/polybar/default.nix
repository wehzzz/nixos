{ pkgs, ... }:
let
  # colors.
  background = "#1E1E2E";
  background-alt = "#1E1E2E";
  foreground = "#C5C8C6";
  primary = "#F0C674";
  secondary = "#8ABEB7";
  alert = "#A54242";
  disabled = "#707880";
  white = "#EAEAEA";
  grey = "#61616C";
  green = "#25D865";
  blue = "#168ECA";
  mauve = "#490761";

in {
  services.polybar = {
    enable = true;
    config = {
      "global/wm" = {
        margin-top = 0;
        margin-bottom = 0;
        dpi = 100;
        padding-left = 0;
        padding-right = 0;
      };

      "bar/main" = {
	#polybar -M | cut -d ':' -f 1
	monitor = "HDMI-A-0";
        width = "100%";
        height = "25pt";
        radius = "10";
	cursor-click = "pointer";
	background = "${background}";
	foreground = "${foreground}";

	font-0 = "JetBrainsMono Nerd Font:weight=bold:size=10";
	font-1 = "Symbols Nerd Font Mono:size=12";

	line-size = "3pt";

	border-size = "2pt";
	border-color = "#0000000";

	padding-left = 1;
	padding-right = 1;

	module-margin = 0;

	modules-left = "nix space date space space spo space spotify";
	modules-center = "xworkspaces";
	modules-right = "cava space space space space space mic space pulseaudio space separator space backlight space separator space battery space separator space wlan space";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";
	
 	label-active = "";
	label-active-padding = 1;
	label-active-foreground = "${disabled}";
	label-active-font = 1;

	label-occupied = "";
	label-occupied-padding = 1;
	label-occupied-font = 1;

	label-empty = "";
	label-empty-background = "${background}";
	label-empty-padding = 1;
	label-empty-font = 1;
      };

      "modules/xwindow" = {
	type = "internal/xwindow";
	label = "%title:0:60:...%";
      };

     "network-base" = {
	type = "internal/network";
	interval = 5;
	format-connected = "<laprimarybel-connected>";
	format-disconnected = "<label-disconnected>";
	label-disconnected = "%{F#F0C674}%ifname%%{F#707880} disconnected";
      };

      "module/wlan" = {
	type = "internal/network";
	interface-type = "wireless";

	interval = 1;
	format-connected-prefix-foreground = "${white}";
	format-connected-foreground = "${white}";
	format-connected = "<label-connected>";
	label-connected = "󰖩";
	label-connected-padding = 0;

	format-disconnected = "<label-disconnected>";
	format-disconnected-padding = 0;
	label-disconnected = "󰖪";
	label-disconnected-foreground = "${white}";
	label-disconnected-padding = 0;
      };

      "module/backlight" = {
        type = "internal/backlight";
	#ls -1 /sys/class/backlight/
        card = "amdgpu_bl1";
        use-actual-brightness = true;
        enable-scroll = true;
        format = "<ramp> <label>";
	format-foreground = "${white}";
	label = "%percentage%%";

	ramp-0 = "󰃞";
	ramp-1 = "󰃝";
	ramp-2 = "󰃟";
	ramp-3 = "󰃠";
      };

      "module/spotify" = {
	type = "custom/script";
	exec = ""; # "~/Scripts/media.sh";
	interval = 1;
	format = "<label>";
	label = "%output%";
      };
	
      "settings" = {
	screenchange-reload = "true";
	pseudo-transparency = "true";
      };

      "module/pulseaudio" = {
	type = "internal/alsa";

	format-volume-prefix = "󰕾 ";
	format-volume-foreground = "${foreground}";
	format-volume-prefix-foreground = "${foreground}";
	format-volume = "<label-volume>";
	label-volume = "%percentage%%";

	label-muted = "󰖁 %percentage%%";
	label-muted-foreground = "${disabled}";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%I:%M %p|%d-%m-%y";
        label = "%date%";
        format-foreground = "${white}";
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 99;
        low-at = 20;
	# ls -1 /sys/class/power_supply/
        battery = "BAT0";
        adapter = "ADP0";
        poll-interval = 5;
	format-charging-foreground = "${foreground}";
	format-discharging-foreground = "${foreground}";
	format-charging = "<animation-charging><label-charging>";
	format-discharging = "<ramp-capacity><label-discharging>";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "Full";
        label-low = "LOW";

	ramp-capacity-0 = " ";
	ramp-capacity-1 = " ";
	ramp-capacity-2 = " ";
	ramp-capacity-3 = " ";
	ramp-capacity-4 = " ";

	bar-capacity-width = 10;

	animation-charging-0 = " ";
	animation-charging-1 = " ";
	animation-charging-2 = " ";
	animation-charging-3 = " ";
	animation-charging-4 = " ";
	animation-charging-framerate = 750;

	animation-discharging-0 = " ";
	animation-discharging-1 = " ";
	animation-discharging-2 = " ";
	animation-discharging-3 = " ";
	animation-discharging-4 = " ";

	animation-discharging-framerate = 500;

	animation-low-0 = "!";
	animation-low-1 = "";
	animation-low-framerate = 200;
      };

      "module/spo" = {
	type = "custom/script";
	tail = true;
	interval = 1;
	format = " <label>";
      	exec = "${pkgs.playerctl}/bin/playerctl metadata --format \"{{artist}}\"";	
      };

      "module/nix" = {
	type = "custom/text";
	content = "";
	content-foreground = "${blue}";
	content-margin = 0;
      };

      "module/space" = {
	type = "custom/text";
	content = " ";
      };

      "module/separator" = {
	type = "custom/text";
	content = "|";
	content-foreground = "${disabled}";
      };

      # https://github.com/sagotsky/.dotfiles/blob/master/config/polybar/config
      "module/ipc-dunst" = {
        type = "custom/ipc";
        initial = 1;
        hook-0 = ''
          echo "%{A1:dunstctl set-paused true && polybar-msg hook ipc-dunst 2:}🔔%{A}" &'';
        hook-1 = ''
          echo "%{A1:dunstctl set-paused false && polybar-msg hook ipc-dunst 1:}%{F#ff2200}🔕%{F-}%{A}" &'';
      };

      "module/menu-apps" = {
        type = "custom/menu";
        expand-right = true;
        label-open = "➕";
        label-close = "➖ ";
        menu-0-0 = "Shutdown |";
        menu-0-0-exec =
          "zenity --question --title 'shutdown' --text 'shutdown now?' && shutdown now";
        menu-0-1 = " Restart";
        menu-0-1-exec =
          "zenity --question --title 'restart' --text 'restart now?' && reboot";
      };

    };
    script = "polybar main --log=error &";
  };
}
