{ config, pkgs, ... }:
{
  import = [
    ../../virtualization/docker.nix
  ];

  environment.systemPackages = with pkgs; [
    cross
  ];
}
