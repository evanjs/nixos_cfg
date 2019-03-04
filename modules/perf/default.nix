{ config, pkgs, ... }:
{
  imports = [
    ./benchmarking.nix
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    perf
  ];
}
