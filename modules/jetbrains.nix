{ config, pkgs, ... }:
let

  #jetPkgs = with pkgs.unstable-small.jetbrains; [
    #clion
    #datagrip
    #idea-ultimate
    #jdk
    #phpstorm
    #pycharm-professional
    #webstorm
  #];

  # TODO: Can we zip the jetbrains set with a list of channels, or similar?
  jetPkgs = with pkgs; [
    (pkgs.versions.latestVersion [pkgs.jetbrains.clion pkgs.unstable.jetbrains.clion pkgs.unstable-small.jetbrains.clion])
    (pkgs.versions.latestVersion [pkgs.jetbrains.datagrip pkgs.unstable.jetbrains.datagrip pkgs.unstable-small.jetbrains.datagrip])
    (pkgs.versions.latestVersion [pkgs.jetbrains.idea-ultimate pkgs.unstable.jetbrains.idea-ultimate pkgs.unstable-small.jetbrains.idea-ultimate])
    (pkgs.versions.latestVersion [pkgs.jetbrains.jdk pkgs.unstable.jdk pkgs.unstable-small.jdk])
    (pkgs.versions.latestVersion [pkgs.jetbrains.phpstorm pkgs.unstable.jetbrains.phpstorm pkgs.unstable-small.jetbrains.phpstorm])
    (pkgs.versions.latestVersion [pkgs.jetbrains.pycharm-professional pkgs.unstable.jetbrains.pycharm-professional pkgs.unstable-small.jetbrains.pycharm-professional])
    (pkgs.versions.latestVersion [pkgs.jetbrains.webstorm pkgs.unstable.jetbrains.webstorm pkgs.unstable-small.jetbrains.webstorm])
  ];

in
  {
    environment.systemPackages = [
    ]
    ++ jetPkgs
    ;
  }
