{ config, lib, ... }: {
  options.modules.doh.enable = lib.mkEnableOption "DnsOverHttps";

  config = lib.mkIf config.modules.doh.enable {
    networking = {
      nameservers = [ "127.0.0.1" "::1" ];
      dhcpcd.extraConfig = "nohook resolv.conf";
      networkmanager.dns = "none";
    };

    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = config.networking.enableIPv6;
        block_ipv6 = ! (config.networking.enableIPv6);

        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
    };
  };
}