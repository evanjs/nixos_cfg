{ config, pkgs, ... }:
{
  imports = [
    ../../virtualization/docker.nix
  ];

  environment.systemPackages = with pkgs; [
    cross
  ];
}
