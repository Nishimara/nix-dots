let
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGHNm+K2k+ElPIKtjRuMt1tvkjaDy310wbTiWIVNDwK";
  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILn48m44TCPXnnjk8DBG24lRoAuL/3AckfkkrO9yFCJX";
  systems = [ nixos thinkpad ];
in {
  "xray.age".publicKeys = systems;
}
