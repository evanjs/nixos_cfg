{ config, pkgs, ... }:
{
  imports = [
    ./vim.nix
  ];

  environment.systemPackages = with pkgs; [
    haskellPackages.hoogle
  ];

  services = {
    hoogle = {
      enable = true;
      port = 8088;
    };
  };
}
