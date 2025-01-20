{ ... }:

{
  programs.gpg = {                                                      
    enable = false;
  };

  services.gpg-agent = {
    enable = false;
  };
}
