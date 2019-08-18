{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hies
  ];
}
