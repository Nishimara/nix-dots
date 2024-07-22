{ ... }: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof swaylock || swaylock -e";
      };

      listener = {
        timeout = 600;
        on-timeout = "loginctl lock-session";
      };
    };
  };
}