let
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGHNm+K2k+ElPIKtjRuMt1tvkjaDy310wbTiWIVNDwK";
  systems = [ nixos ];
in {
  "xray.age".publicKeys = systems;
}
