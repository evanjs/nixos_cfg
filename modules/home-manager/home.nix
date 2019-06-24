{ config, pkgs, ... }:
{
  imports = [
    ./compton.nix
    ./email.nix
    ./firefox.nix
    ./style
  ];

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

  programs.home-manager = {
    enable = true;
  };
  programs.lsd = {
    enableAliases = true;
    enable = true;
  };
  programs.skim = {
    enable = true;
    defaultCommand = "fd --type f";
  };
}
