{ config, pkgs, ... }:
{
  imports = [
    ./compton.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./lib.nix
    ../jetbrains.nix
    ./randr
    ./security
    ./security/gpg.nix
    ./services
    ./style
    ./xorg

    # shells
    ./bash
    ./zsh
  ];

  home = {
    sessionVariables = config.lib.sessionVariables;
  };

  programs = {
    git = {
      enable = true;
      userEmail = "evanjsx@gmail.com";
      userName = "Evan Stoll";
      ignores = (import ./git/ignores_formatted.nix);
    };
    home-manager = {
      enable = true;
    };
    lsd = {
      enableAliases = true;
      enable = true;
    };
    rofi = {
      enable = true;
      theme = "Monokai";
    };
    skim = {
      enable = true;
      defaultCommand = "fd --type f";
      enableZshIntegration = true;
    };
  };
}
