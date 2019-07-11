{ config, pkgs, lib, ... }:

with lib;
let
  channels = [
    pkgs
    pkgs.unstable
    pkgs.unstable-small
  ];

  getNewestFromChannels = name: pkgs.versions.latestVersion ((_: map (channel: (getAttr name channel.jetbrains)) channels) name);

  jetPkgs = [
    (getNewestFromChannels "clion")
    (getNewestFromChannels "jdk")
    (getNewestFromChannels "webstorm")
  ];

in
  {
    environment.systemPackages = [ ]
    ++ jetPkgs
    ;
  }
