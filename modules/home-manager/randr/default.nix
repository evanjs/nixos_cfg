{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    #./hooks.nix
  ];

  programs.autorandr = {
    enable = true;
  };
}
