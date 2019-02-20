{ config, pkgs, ... }:

let
  nodePkgs = with pkgs.nodePackages; [
    grunt-cli
    node2nix
  ];

in
  {

    imports = [
      ./languages.nix
    ];

    environment.systemPackages = with pkgs; [
      # js
      nodejs-10_x
      sass
#      phantomjs
#      nodePackages.phantomjs
      php # for cgi, etc

      # python
      #python36Full
      #python36Packages.setuptools
#      python37Full
 #     python37Packages.setuptools

      exercism

      # debugging
      gdb
      lldb

      cmake
      gnumake

      postman

      maven3
    ]
    ++ nodePkgs;
  }
