{ pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "Nishimara";
    userEmail = "admin@abdulakh.fun";
    signing = {
      key = "/home/ayako/.ssh/gitsign.pub";
      signByDefault = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
      };
    };
  };
}