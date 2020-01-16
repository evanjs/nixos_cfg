{ config , pkgs , ... }:
let
  outOfTree = with pkgs; [
    kivymd
    kivy
    kivy-garden
    material-ui
  ];
in
  {
  imports = [
    ./db/postgresql.nix
  ];

  environment.systemPackages = with pkgs.stable.python37Packages; [
    multiprocess
    pillow
    requests
    scrapy
    twisted
    sqlalchemy
  ];
}
