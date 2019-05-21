{ config, lib, pkgs, ... }:
let
  imports = [
    ./unstable.nix
  ];
  latestKernel = lib.head (lib.sort (a: b: a.kernel.version > b.kernel.version) [
    pkgs.linuxPackages_latest
    pkgs.unstable.linuxPackages_latest
    pkgs.unstable-small.linuxPackages_latest
  ]);
  #name = lib.attrsets.toDerivation (lib.head (lib.intersperse "." [ latestKernel.c latestKernel.p ]));
in
  {
    boot.kernelPackages = latestKernel;
  }
