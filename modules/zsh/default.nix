{ config, pkgs, ... }:
{

  imports = [
    ./oh.nix
  ];

  environment = {
    pathsToLink = [ "/share/zsh" ];
  };

  programs.zsh = {
    autosuggestions = {
      enable = true;
    };
    history = {
      ignoreDups = false;
      expireDuplicatesFirst = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    enable = true;
  };

  # enable completion for system packages (e.g. systemd)
  users.users.evanjs.shell = pkgs.zsh;
  users.users.root.shell = pkgs.zsh;
}
