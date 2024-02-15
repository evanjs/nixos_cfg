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
      sass

      exercism

      # debugging
      gdb
      cgdb
      lldb

      binutils

      cmake
      gnumake

      maven3

      # testing
      websocat

      glade
    ]
    ++ nodePkgs;
  }
