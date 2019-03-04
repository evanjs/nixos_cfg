{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    flamegraph
    hyperfine
  ];
}
