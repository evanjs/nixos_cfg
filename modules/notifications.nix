  { config, pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      stable.ntfy
    ];
  }
