{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting;
      fish_config theme choose "Dracula";

      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
    '';

    shellAliases = {
      wttr = "curl wttr.in";
      tb = "nc termbin.com 9999";
    };

    plugins = with pkgs.fishPlugins; [
      { name = "grc"; inherit (grc) src; }
      { name = "z"; inherit (z) src; }
      { name = "bass"; inherit (bass) src; }
      { name = "fzf"; inherit (fzf) src; }
    ];
  };

  xdg.configFile."fish/themes/Dracula.theme".source = let
    dracula = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "fish";
      rev = "269cd7d76d5104fdc2721db7b8848f6224bdf554";
      sha256 = "sha256-Hyq4EfSmWmxwCYhp3O8agr7VWFAflcUe8BUKh50fNfY=";
    };
  in "${dracula}/themes/Dracula Official.theme";
}