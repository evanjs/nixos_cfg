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
      ./channels.nix
    ];

    environment.systemPackages = with pkgs; [
      # js
      nodejs-10_x
      sass

      exercism
      pkgs.stable.nodePackages."@angular/cli" # fails to build on unstable

      # debugging
      gdb
      cgdb
      lldb

      binutils

      cmake
      gnumake

      postman

      maven3

      # testing
      websocat

      pypi2nix
    ]
    ++ nodePkgs;
  }
