let
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMYj9Dd4kG2oshwinQ0wrBkMv7YU5z2qbB8ct65th5Ul";
  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILn48m44TCPXnnjk8DBG24lRoAuL/3AckfkkrO9yFCJX";
  systems = [ nixos thinkpad ];
in {
  "xray.age".publicKeys = systems;
}