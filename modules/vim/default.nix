{ config, pkgs, ... }:
{
  imports = [
    ./neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    ranger
    vifm
    universal-ctags
  ];
}
