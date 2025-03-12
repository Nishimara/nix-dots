{ pkgs, ... }: {
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;

        show_hidden = true;
        show_symlink = true;

        linemode = "none";
      };

      preview = {
        tab_size = 2;
      };

      opener = {
        play = [
          { run = "${pkgs.vlc}/bin/vlc $@"; orphan = true; }
        ];
      };
    };
  };
}