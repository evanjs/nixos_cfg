{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    megatools
  ];
}
