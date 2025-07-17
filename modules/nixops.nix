{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixops
  ];

  services.nixops-dns = {
    enable = true;
    user = "evanjs";
  };
}
