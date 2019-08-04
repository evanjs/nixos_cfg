{ config, pkgs, ... }:
{
  imports = [
    ./home.nix
    ./work.nix
    ./work2.nix
  ];

  home-manager.users.evanjs = {
    programs.autorandr = {
      enable = true;
    };
  };
}
