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

    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      gpg = {
        format = "ssh";
      };
    };
  };

  programs.lazygit.enable = true;
}