{ config, pkgs, ... }:
{
  environment.systemPackages = [
    (import ./neovim.nix)
    (import ./vim.nix)
  ];
}
