{ config, lib, pkgs, ... }:
with lib;
let
  defaultUser = "evanjs";
in
{
  imports = [
    ./nixos-wsl
  ];

  config.wsl = {
    inherit defaultUser;
  };
}
