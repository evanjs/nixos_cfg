{ config, pkgs, ... }:
{

  imports = [
    ./cargo.nix
    ./cross.nix
    ./documentation
    ./sccache.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo-asm
    cargo-edit
    openssl.dev
    pkgconfig
    rustup
  ];
}
