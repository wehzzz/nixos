{ pkgs, ... }:

{
  # Activer Helix via Home Manager
  programs.helix = {
    enable = true;

    # Configuration de Helix
    settings = {
      theme = "catppucin_mocha";  # Thème de couleur
      editor = {
        line-number = "relative";  # Numéros de ligne relatifs
        cursorline = true;         # Mettre en évidence la ligne du curseur
        indent-guides.render = true;  # Guides d'indentation
      };
    };

    # Configuration des langues
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
        }
      ];
    };
  };
}
