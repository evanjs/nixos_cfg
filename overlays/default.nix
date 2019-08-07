{ config, pkgs, lib, ... }:
{
  imports = [
    ./evanjs
    ./hie-nix
    ./libs
    ./mozilla
    ./nix-helpers
    ./rjg
    ./taffybar
  ]
  ++ (if (builtins.pathExists(./default.local.nix)) then [ ./default.local.nix ] else [])
  ;
}


