{ config, pkgs, ... }:

{

  imports = [
    ../../../../overlays
    ../../../new-modules/default-hm.nix
    ../../../new-modules/dev/moz-overlay.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    bat
    fd
    du-dust
    nixpkgs-fmt
    git
    python3
  ];

  programs = {
    lsd = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableAliases = true;
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    bash = {
      enable = false;
    };
  };
  
  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
