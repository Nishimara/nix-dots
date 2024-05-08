{ ... }:
{
  programs.git = {
    enable = true;

    userName = "Nishimara";
    userEmail = "admin@abdulakh.fun";

    signing = {
      key = "/home/ayako/.ssh/gitsign.pub";
      signByDefault = true;
    };

    difftastic = {
      enable = true;
      background = "dark";
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

  programs.lazygit.enable = true;
}