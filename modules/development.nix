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
      php # for cgi, etc


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
    ]
    ++ nodePkgs;
  }
