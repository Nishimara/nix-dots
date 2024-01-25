{ pkgs, nixvim, ...}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
