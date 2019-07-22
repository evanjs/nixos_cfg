{ pkgs ? import <nixpkgs> {} }:

with pkgs; callPackage ./wrapper.nix {}
