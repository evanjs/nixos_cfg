{ config, pkgs, ... }:
{
  imports = [
    ./unstable.nix
    ];
  environment.systemPackages = with pkgs.unstable-small; [
    libreoffice-unwrapped
  ];
}
