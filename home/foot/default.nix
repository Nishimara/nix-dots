{ ... }: {
  programs.foot = {
    enable = true;
    
    settings = {
      main = {
        term = "xterm-256color";
        font = "Hack Nerd Font:size=14";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      cursor = {
        style = "beam";
        blink = "yes";
      };

      colors = {
        alpha = "0.8";

        # mocha theme

        foreground = "cdd6f4";
        background = "1e1e2e";

        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";

        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e2a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";

        selection-foreground = "cdd6f4";
        selection-background = "414356";

        search-box-no-match = "11111b f38ba8";
        search-box-match = "cdd6f4 313244";

        jump-labels = "11111b fab387";
        urls = "89b4fa";
      };
    };
  };
}