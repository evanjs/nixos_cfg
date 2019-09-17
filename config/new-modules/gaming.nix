{ lib, config, pkgs, ... }:

with lib;

{

  options.mine.gaming.enable = mkEnableOption "games";

  config = mkIf config.mine.gaming.enable {
  environment.systemPackages = with pkgs; [
    ( pkgs.versions.latestVersion [ pkgs.steam pkgs.nixos-unstable.steam pkgs.nixos-unstable-small.steam ] )
    ( pkgs.versions.latestVersion [ pkgs.steam-run pkgs.nixos-unstable.steam-run pkgs.nixos-unstable-small.steam-run ])
  ];
  
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.support32Bit = true;
  };

    hardware.steam-hardware.enable = true;
    boot.blacklistedKernelModules = [ "hid_steam" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0666"
    '';

    nixpkgs.config.pulseaudio = true;
  };

}
