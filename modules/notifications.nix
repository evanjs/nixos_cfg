  { config, pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      # ntfy is broken in nixpkgs
      #ntfy
    ];
  }
