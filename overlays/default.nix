{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


