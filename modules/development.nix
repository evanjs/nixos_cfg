{ config, pkgs, ... }:

let
  nodePkgs = with pkgs.nodePackages; [
    node2nix
  ];
in
  {
    imports = [
      ./documentation
      ./languages
      ./perf
    ];

    environment.systemPackages = with pkgs; [
      nodePackages."@angular/cli"
      # js
      nodejs-12_x
      sass

      exercism

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

      gnome3.glade
    ]
    ++ nodePkgs;
  }
