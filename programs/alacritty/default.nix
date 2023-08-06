{ pkgs, specialArgs, ... }:

let
  fontSize = 10;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        title = "Terminal";

	padding = {
  	  x = 10;
	  y = 10;
	};

        position = {
          x = 900;
          y = 350;
        };
        dimensions = {
          lines = 24;
          columns = 82;
        };
	
	decorations = "none";
	startup_mode = "windowed";
	dynamic_title = true;

	history = 10000;
	multiplier = 3;
	
	opacity = 1.0;
      };

      cursor = {
        style = {
	  shape = "block";
	  blinking = "on";
	};
      };
      
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 10.0;
      };

      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };

      colors = {
        primary = {
    	  background = "#1e222a";
    	  foreground = "#c8ccd4";
	};

  	# Normal colors
  	normal = {
    	  black=   "#1e222a";
    	  red=     "#e06c75";
    	  green=   "#98c379";
    	  yellow=  "#e5c07b";
    	  blue=    "#61afef";
    	  magenta= "#c678dd";
    	  cyan=    "#56b6c2";
    	  white=   "#abb2bf";
        };

  	# Bright colors
  	bright = {
    	  black=   "#545862";
    	  red=     "#e06c75";
    	  green=   "#98c379";
    	  yellow=  "#e5c07b";
    	  blue=    "#61afef";
    	  magenta= "#c678dd";
    	  cyan=    "#56b6c2";
    	  white=   "#c8ccd4";
	};
      }; 
    };
  };
}
