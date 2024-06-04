{ ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;

      format = "$all";

      directory = {
        truncate_to_repo = false;
      };
    };
  };
}