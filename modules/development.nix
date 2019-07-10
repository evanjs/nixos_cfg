{ config, pkgs, ... }:

let
  nodePkgs = with pkgs.nodePackages; [
    grunt-cli
    node2nix
  ];

in
  {
    imports = [
      ./documentation
      ./languages
      ./perf
      ./unstable.nix
    ];

    environment.systemPackages = with pkgs; [
      # js
      nodejs-10_x
      sass

      exercism
      (builtins.elemAt (lib.attrValues (lib.filterAttrs (n: v: n == "@angular/cli") pkgs.nodePackages)) 0)

      # debugging
      gdb
      lldb

      cmake
      gnumake

      unstable.postman

      maven3

      # testing
      websocat

      pypi2nix
    ]
    ++ nodePkgs;
  }
