{ config, pkgs, ... }:
{
  imports = [
    ./machines/work
  ];
  nixpkgs.config.allowUnfree = true;

}
