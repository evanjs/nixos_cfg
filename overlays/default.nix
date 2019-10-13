{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./libs
    #./nix-helpers
    ./rjg
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


