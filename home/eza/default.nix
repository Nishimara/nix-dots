{ ... }:
{
  programs.eza = {
    enable = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--octal-permissions"
      "--header"
    ];
  };
}