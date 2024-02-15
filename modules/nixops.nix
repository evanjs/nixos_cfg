{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixopsUnstable
  ];

  services.nixops-dns = {
    enable = false;
    user = "evanjs";
  };
}
