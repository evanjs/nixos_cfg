{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zeal
  ];
}
