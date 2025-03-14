{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        pkief.material-icon-theme
      ];

      userSettings = {
        "editor.fontSize" = 16;
        "editor.fontFamily" = "Hack Nerd Font";
        "editor.renderLineHighlight" = "none";
        "editor.unicodeHighlight.allowedLocales".ru = true;
        "terminal.integrated.fontFamily" = "Hack Nerd Font";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "Catppuccin Frappé";
        "workbench.iconTheme" = "material-icon-theme";
      };
    };
  };
}