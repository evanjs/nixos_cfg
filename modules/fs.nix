{ config, pkgs, ... }:
let
  exfat-nofuse = config.boot.kernelPackages.exfat-nofuse.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ /etc/nixos/patches/exfat/MS_toSB_macros.patch ];

    });
in
{
  boot.extraModulePackages = [
    #config.boot.kernelPackages.exfat-nofuse 
    exfat-nofuse
  ];
}
