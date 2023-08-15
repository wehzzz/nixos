{ pkgs, lib,... }:
let
  # colors.
  background = "#1E2128";
  foreground = "#ABB2BF";
  altbackground = "#292d37";
  altforeground = "#5a6477";  
  accent = "#5294E2";

  black = "#32363D";
  red = "#E06B74";
  green = "#98C379";
  yellow = "#E5C07A";
  blue = "#62AEEF";
  magenta = "#C778DD";
  cyan = "#55B6C2";
  white = "#ABB2BF";
  altblack = "#50545B";
  altred = "#EA757E";
  altgreen = "#A2CD83";
  altyellow = "#EFCA84";
  altblue = "#6CB8F9";
  altmagenta = "#D282E7";
  altcyan = "#5FC0CC";
  altwhite = "#B5BCC9";

in {
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };

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
	monitor = "\${env:MONITOR:}";
	monitor-fallback = "eDP";
	monitor-strict = false;
	override-redirect = true;
	wm-restack = "i3";
	bottom = false;
	fixed-center = true;

        width = "98.8%";
        height = "20pt";
        radius = "0";
	cursor-click = "pointer";
	background = "${background}";
	foreground = "${foreground}";

	font-0 = "JetBrainsMono Nerd Font:size=10;3";
	font-1 = "Symbols Nerd Font Mono:size=12;3";
	font-2 = "Iosevka Nerd Font:size=15;4";
	font-3 = "Iosevka Nerd Font:size=10;4";
	font-4 = "Symbols Nerd Font Mono;size=14;3";
	font-5 = "Symbols Nerd Font Mono;size=18;4";

	line-size = "2pt";
	line-color = "${accent}";

	border-size = "4pt";
	border-color = "${background}";

	padding-left = 0;
	padding-right = 0;

	module-margin = 0;

	modules-left = "space2 menu dot-alt i3 dot cpu dot used-memory";
	modules-center = "LD date RD dot-alt LD song-prev song-pause song-next RD sep song";
	modules-right = "volume dot backlight dot bluetooth dot wlan dot LD battery RD dot-alt LD sysmenu RD";
      	
	separator = "";
	spacing = 0;

	tray-position = "right";
	tray-detached = false;
	tray-maxsize = 16;
	tray-background = "${background}";
	tray-padding = 0;
	tray-scale = "1.0";

	offset-x = "0.65%";
	offset-y = "0.8%";
	
	enable-ipc = true;   	
      };

      "settings" = {
	screenchange-reload = "true";
	pseudo-transparency = "true";
      
	compositing-background = "source";
	compositing-foreground = "over";
	compositing-overline = "over";
	compositing-underline = "over";
	compositing-border = "over";
      };

      "module/i3" = {
	type = "internal/i3";

	pin-workspaces = true;
	strip-wsnumbers = true;
	index-sort = true;
	reverse-scroll = false;

	format = "<label-state><label-mode>";
	format-background = "${background}";
	
	label-mode = "%mode%";
	label-mode-padding = 1;
	label-mode-foreground = "${red}";

	label-focused = "%name%";
	label-focused-background = "${cyan}";
	label-focused-foreground = "${background}";

	label-unfocused = "%name%";

	label-visible = "%name%";
	
	label-urgent = "%name%";
	label-urgent-foreground = "${red}";

      	label-focused-padding = 1;
	label-unfocused-padding = 1;
	label-visible-padding = 1;
	label-urgent-padding = 1;
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
	label-connected = "%{A1:networkmanager_dmenu:}󰖩 %essid%%{A}";
	label-connected-padding = 0;

	format-disconnected = "<label-disconnected>";
	format-disconnected-padding = 0;
	label-disconnected = "%{A1:networkmanager_dmenu:}󰖪%{A}";
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
	format-background = "${background}";
	label = "%percentage%%";

	ramp-0 = "󰃞";
	ramp-1 = "󰃝";
	ramp-2 = "󰃟";
	ramp-3 = "󰃠";
	ramp-foreground = "${cyan}";
      };

      "module/volume" = {
	type = "internal/pulseaudio";

	use-ui-max = false;	

	format-volume-prefix = "󰕾 ";
	format-volume-foreground = "${foreground}";
	format-volume-prefix-foreground = "${foreground}";
	format-volume-background = "${background}";
	format-volume = "<label-volume>";
	
	label-volume = "%percentage%%";

	format-muted = "<label-muted>";
	format-muted-prefix = "󰖁 ";
	format-muted-prefix-foreground = "${altforeground}";
	format-muted-background = "${background}";
	
	label-muted = "Mute";
	label-muted-foreground = "${altforeground}";
        
	click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "module/date" = {
        type = "internal/date";
        
	interval = 1;
	
	date = "%H:%M";
	date-alt = "%a, %d %b %G";       
 
	format = "<label>";
	format-prefix = " ";
	format-prefix-font = 1;
	format-prefix-foreground = "${red}";
	format-background = "${altbackground}";

	label = "%date%";
	label-font = 0;
      };

      "module/used-memory" = {
	type = "custom/script";

	exec = "/run/current-system/sw/bin/free -m | ${pkgs.gnugrep}/bin/grep 'Mem:' | /run/current-system/sw/bin/tr -s ' ' | /run/current-system/sw/bin/cut -d ' ' -f3";

	tail = true;
	interval = 5;

	format = "<label>";
	format-background = "${background}";
	format-padding = 1;

	format-prefix = " ";
	format-prefix-font = 1;
	format-prefix-foreground = "${cyan}";

	label = " %output% MB";

	click-left = "${pkgs.alacritty}/bin/alacritty --hold -e \"htop\"";
      };

      "module/battery" = {
        type = "internal/battery";
        
	full-at = 99;
	
	# ls -1 /sys/class/power_supply/
        battery = "BAT0";
        adapter = "ADP0";

        poll-interval = 2;
	time-format = "%H:%M";

	format-charging = "<animation-charging> <label-charging>";
	format-charging-prefix = " ";
	format-charging-prefix-font = 1;
	format-charging-prefix-foreground = "${red}";
	format-charging-background = "${altbackground}";	

	format-discharging = "<ramp-capacity> <label-discharging>";
	format-discharging-background = "${altbackground}";
        
	label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
	
	format-full = "<label-full>";
	format-full-prefix = " ";
	format-full-prefix-font = 2;
	format-full-prefix-foreground = "${green}";
	format-full-background = "${altbackground}";
        label-full = "%percentage%%"; #Full

	ramp-capacity-0 = " ";
	ramp-capacity-1 = " ";
	ramp-capacity-2 = " ";
	ramp-capacity-3 = " ";
	ramp-capacity-4 = " ";
	ramp-capacity-foreground = "${yellow}";
	ramp-capacity-font = 2;

	animation-charging-0 = " ";
	animation-charging-1 = " ";
	animation-charging-2 = " ";
	animation-charging-3 = " ";
	animation-charging-4 = " ";
	animation-charging-foreground = "${green}";
	animation-charging-font = 2;
	animation-charging-framerate = 700;
      };

      "module/cpu" = {
	type = "internal/cpu";

	interval = "0.5";

	format = "<label>";
	format-prefix = "";
	format-prefix-font = 1;
	format-prefix-foreground = "${yellow}";
	format-background = "${background}";
	format-padding = 1;

	label = " %percentage%%";
      };

      "module/bluetooth" = {
	type = "custom/script";
	exec = "rofi-bluetooth --status 2>/dev/null";
	interval = 1;
	click-left = "rofi-bluetooth -theme bluetooth &";
      };
 
      "module/song-prev" = {
	type = "custom/text";

	content-background = "${altbackground}";
	content-foreground = "${blue}";
	content = "󰒮 ";

	click-left = "${pkgs.playerctl}/bin/playerctl previous";     
      };

      "module/song-pause" = {
	type = "custom/script";

	format = "<label>";
	label = "%output%";
	format-background = "${altbackground}";
	format-foreground = "${green}";
	format-font = 1;
	tail = true;
	interval = 0;

	exec = "~/.dotfiles/programs/polybar/scripts/music_button.sh";
	click-left = "${pkgs.playerctl}/bin/playerctl play-pause";
      }; 

      "module/song-next" = {
	type = "custom/text";

	content-background = "${altbackground}";
	content-foreground = "${blue}";
	content = "󰒭";

	click-left = "${pkgs.playerctl}/bin/playerctl next";     
      };

      "module/song" = {
	type = "custom/script";
	format = "<label>";
	label = "%output%";
      	tail = true;
	exec = "~/.dotfiles/programs/polybar/scripts/music.sh";	
      };

      "module/menu" = {
	type = "custom/text";
	content = " ";
	content-font = 5;
	content-background = "${background}";
	content-foreground = "${blue}";
	content-margin = 0;

	click-left = "${pkgs.rofi}/bin/rofi -show drun -theme launcher";
      };

      "module/sysmenu" = {
	type = "custom/text";

   	content-background = "${altbackground}";
	content-foreground = "${red}";
	content = "⏻ ";

	click-left = "${pkgs.rofi}/bin/rofi -show menu -modi \"menu:rofi-power-menu --choices=lockscreen/logout/reboot/shutdown\" -theme powermenu";
      };

      "module/space" = {
	type = "custom/text";
	content = " ";
	content-background = "${altbackground}";
      };

      "module/space2" = {
	type = "custom/text";
	content = " ";
	content-background = "${background}";
      };

      "module/sep" = {
	type = "custom/text";
	content = "-";
	content-background = "${background}";
	content-foreground = "${background}";
      };

      "module/dot" = {
	type = "custom/text";
	content = "";
	content-foreground = "${altbackground}";
	content-padding = 1;
	content-font = 4;
      };

      "module/dot-alt" = {
	type = "custom/text";
	content = " ";
	content-padding = 1;
	content-font = 4;
	content-foreground = "${altforeground}";
      };
     
      "module/LD" = {
	type = "custom/text";
	content = "%{T3}%{T-}";
	content-background = "${background}";
	content-foreground = "${altbackground}";
      };

      "module/RD" = {
	type = "custom/text";
	content = "%{T3}%{T-}";
	content-background = "${background}";
	content-foreground = "${altbackground}";
      };
    };
    script = "polybar main --log=error &";
  };  
}
