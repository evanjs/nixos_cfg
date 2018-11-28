{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo-edit
    openssl.dev
    pkgconfig
  ];
}
