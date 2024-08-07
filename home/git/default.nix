{ config, ... }:
{
  programs.git = {
    enable = true;

    userName = "Nishimara";
    userEmail = "me@nishimara.com";

    signing = {
      key = "${config.home.homeDirectory}/.ssh/gitsign.pub";
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