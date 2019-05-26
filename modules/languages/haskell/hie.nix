{ pkgs, ... }:
{
  imports = [
    ../../cachix
  ];

  environment.systemPackages = with pkgs; [
    hies
  ];
}
