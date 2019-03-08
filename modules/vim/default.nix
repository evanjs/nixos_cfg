{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (import ./neovim.nix)
    ranger
  ];
}
