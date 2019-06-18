{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./hie-nix
    ./libs
    ./rjg
    ./taffybar
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


