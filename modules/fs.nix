{ config, pkgs, ... }:
let
  exfat-nofuse = config.boot.kernelPackages.exfat-nofuse.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ /home/evanjs/src/nixos_cfg/patches/exfat/MS_toSB_macros.patch ];

    });
in
{
  boot.extraModulePackages = [
    #config.boot.kernelPackages.exfat-nofuse 
    exfat-nofuse
  ];
}
