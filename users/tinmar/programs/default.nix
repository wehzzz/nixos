let
  more = { pkgs, ... }: {
    programs = {
      htop = {
        enable = true;
        settings = {
          sort_direction = true;
          sort_key = "PERCENT_CPU";
        };
      };
      ssh.enable = true;
    };
  };
in
[
  ./alacritty
  more
]
