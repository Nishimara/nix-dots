{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting; # Disable greeting
    '';

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
    ];
  };
}