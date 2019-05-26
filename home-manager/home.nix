{ config, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userEmail = "evanjsx@gmail.com";
      userName = "Evan Stoll";
      ignores = (import ./git/ignores_formatted.nix);
    };
    rofi = {
      enable = true;
      theme = "Monokai";
    };
  };
}
