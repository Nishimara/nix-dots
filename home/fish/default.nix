{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting; # Disable greeting

      alias wttr="curl wttr.in"
      alias tb="nc termbin.com 9999"
    '';

    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
    ];
  };
}