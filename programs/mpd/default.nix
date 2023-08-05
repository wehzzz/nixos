{...}:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/path/to/music";
    extraConfig = ''
      ALSA
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
}
