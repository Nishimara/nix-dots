{ config, lib, ... }: {
  options.modules.hosts.enable = lib.mkEnableOption "Enable blocklist";

  config = lib.mkIf config.modules.hosts.enable {
    networking.stevenblack = {
      enable = true;
      block = [ "gambling" ];
    };

    networking.hosts = {
      "0.0.0.0" = [
        "overseauspider.yuanshen.com"
        "log-upload-os.hoyoverse.com"
        "log-upload-os.mihoyo.com"
        "dump.gamesafe.qq.com"

        "log-upload.mihoyo.com"
        "devlog-upload.mihoyo.com"
        "uspider.yuanshen.com"
        "osuspider.yuanshen.com"
        "sg-public-data-api.hoyoverse.com"
        "ys-log-upload-os.hoyoverse.com"
        "public-data-api.mihoyo.com"

        "prd-lender.cdp.internal.unity3d.com"
        "thind-prd-knob.data.ie.unity3d.com"
        "thind-gke-usc.prd.data.corp.unity3d.com"
        "cdp.cloud.unity3d.com"
        "remote-config-proxy-prd.uca.cloud.unity3d.com"  
      ];
    };
  };
}