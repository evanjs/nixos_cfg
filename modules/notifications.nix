  { config, pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      ntfy
    ];
  }
