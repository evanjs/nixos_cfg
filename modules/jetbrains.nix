{ config, pkgs, ... }:
let
  jetPkgs = with pkgs.unstable.jetbrains; [
    clion
    idea-ultimate
    jdk
    phpstorm
    pycharm-professional
    webstorm
  ];

in
  {
    environment.systemPackages = [
    ]
    ++ jetPkgs
    ;
  }
