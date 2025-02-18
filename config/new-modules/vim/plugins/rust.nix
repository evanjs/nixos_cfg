{ config, pkgs, lib, programs, ... }:
with lib;
{
  programs.nixvim = {
    plugins = {
      crates-nvim.enable = true;
      rustaceanvim.enable = true;
    };
  };
}
