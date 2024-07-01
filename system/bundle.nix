{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./tmux
    ./neovim
    ./xray
    ./proxychains
#   ./gnome
    ./nvidia
  ];
}