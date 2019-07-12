{ config, pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./compton.nix
    ./email.nix
    ./firefox.nix
    ./lib.nix
    ./randr
    ./security
    ./security/gpg.nix
    ./style
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
    gpg = {
      enable = true;
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
    };
  };
}
