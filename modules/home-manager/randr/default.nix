{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./work.nix
  ];

  programs.autorandr = {
    enable = true;
  };
}
