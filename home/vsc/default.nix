{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      pkief.material-icon-theme
    ];

    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 16;
      "editor.fontFamily" = "Hack Nerd Font";
      "terminal.integrated.fontFamily" = "monospace";
      "editor.unicodeHighlight.allowedLocales".ru = true;
      "window.titleBarStyle" = "custom";
      "editor.renderLineHighlight" = "none";
    };
  };
}