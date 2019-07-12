{ config, pkgs, ... }:
{
  imports = [
    ./cargo.nix
    ./cross.nix
    ./documentation
  ];

  environment.systemPackages = with pkgs; [
    openssl.dev
    pkgconfig
    nightly-rust-with-extensions.std-only
  ];
}
