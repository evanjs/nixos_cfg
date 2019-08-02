{ config, pkgs, lib, ... }:

with lib;
let
  channels = [
    pkgs
    pkgs.stable
    pkgs.unstable-small
  ];

  getNewestFromChannels = name: pkgs.versions.latestVersion ((_: map (channel: (getAttr name channel.jetbrains)) channels) name);

  jetPkgs = [
    (getNewestFromChannels "idea-ultimate")
    (getNewestFromChannels "clion")
    (getNewestFromChannels "datagrip")
    (getNewestFromChannels "jdk")
    (getNewestFromChannels "pycharm-professional")
    (getNewestFromChannels "webstorm")
  ];

in
  {
    imports = [
      ./channels.nix
    ];

    home.packages = [ ]
    ++ jetPkgs
    ;
  }
