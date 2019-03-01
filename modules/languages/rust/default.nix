{ config, pkgs, ... }:
{

  imports = [
    ./documentation
    ./rustup.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo-asm
    cargo-edit
    openssl.dev
    pkgconfig
    rustup
    #sccache
  ];
}
