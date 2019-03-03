{ config, pkgs, ... }:
{

  imports = [
    ./cargo.nix
    ./cross.nix
    ./sccache.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo-edit
    openssl.dev
    pkgconfig
    rustup
  ];
}
