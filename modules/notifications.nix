  { config, pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      pkgs.ntfy
    ];
  }
