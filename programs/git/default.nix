{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "martin.levesque@epita.fr";
    userName = "Martin Levesque";
    delta.enable = true;

    ignores = [ "*~" "*.swp" ".o" ".d" "format_marker"];

    aliases = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      };

    extraConfig = {
      push.autoSetupRemote = true;
      init.defaultbranch = "main";
      };
  };
}
