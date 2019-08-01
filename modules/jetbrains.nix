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
    (getNewestFromChannels "clion")
    (getNewestFromChannels "idea-ultimate")
    (getNewestFromChannels "jdk")
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
