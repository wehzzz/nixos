{ pkgs, ... }:

{
  # Activer Helix via Home Manager
  programs.helix = {
    enable = true;

    # Configuration de Helix
    settings = {
      theme = "catppuccin_mocha";  # Thème de couleur
      editor = {
        cursorline = true;         # Mettre en évidence la ligne du curseur
        indent-guides.render = true;  # Guides d'indentation
      	preview-completion-insert = false;
      };

      keys.normal = {
        # Macro pour aller à la fin du mot suivant sans sélectionner
        "C-right" = [
          "move_next_word_end"  # Déplacer à la fin du mot suivant
          "collapse_selection"  # Annuler la sélection
        ];

        # Macro pour aller au début du mot précédent sans sélectionner
        "C-left" = [
          "move_prev_word_start"  # Déplacer au début du mot précédent
          "collapse_selection"    # Annuler la sélection
        ];

        # Sélectionner à partir du curseur
        "S-up" = "select_line_above";     # Ctrl + flèche haut : aller au paragraphe précédent
        "S-down" = "select_line_below";   # Ctrl + flèche bas : aller au paragraphe suivant
        "S-right" = "extend_char_right";          # Maj + flèche droite : sélectionner le caractère suivant
        "S-left" = "extend_char_left";            # Maj + flèche gauche : sélectionner le caractère précédent

        "C-S-right" = "extend_next_word_end";     # Ctrl + Maj + flèche droite : sélectionner jusqu'à la fin du mot suivant
        "C-S-left" = "extend_prev_word_start";    # Ctrl + Maj + flèche gauche : sélectionner jusqu'au début du mot précédent
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
