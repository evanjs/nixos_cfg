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
