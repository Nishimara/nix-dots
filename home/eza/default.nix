{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--octal-permissions"
      "--header"
    ];
  };
}