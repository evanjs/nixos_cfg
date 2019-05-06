{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    kivy
    kivy-garden
    material-ui
    kivymd
  ];
}
