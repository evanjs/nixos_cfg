{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./work.nix
    ./work2.nix
  ];

  programs.autorandr = {
    enable = true;
  };
}
