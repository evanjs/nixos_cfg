{ config, lib, pkgs, ... }:
let
  latestKernel = lib.head (lib.sort (a: b: a.kernel.version > b.kernel.version) [
    pkgs.linuxPackages_latest
    pkgs.nixos-unstable.linuxPackages_latest
    pkgs.nixpkgs-unstable.linuxPackages_latest
    pkgs.nixos-unstable-small.linuxPackages_latest
  ]);
  #name = lib.attrsets.toDerivation (lib.head (lib.intersperse "." [ latestKernel.c latestKernel.p ]));
in
  {
    boot.kernelPackages = latestKernel;
  }
