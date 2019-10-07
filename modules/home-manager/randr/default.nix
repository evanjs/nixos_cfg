{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./work.nix
    ./work2.nix
    ./wdesk.nix
  ];

  home-manager.users.evanjs = {
    programs.autorandr = {
      enable = true;
    };
  };
}
