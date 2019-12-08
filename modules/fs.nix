{ config, pkgs, ... }:
{
  boot.extraModulePackages = [
    config.boot.kernelPackages.exfat-nofuse
  ];

  # Thunderbolt
  environment.systemPackages = with pkgs; [
    thunderbolt
  ];

  services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
  '';
}
