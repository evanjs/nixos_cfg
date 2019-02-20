{ config, pkgs, ... }:
{
  imports = [
    ./docker.nix
    ./virtualbox.nix
  ];
}
