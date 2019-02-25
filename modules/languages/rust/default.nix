{ config, pkgs, ... }:
{

  imports = [
    #./rustup.nix
  ];

  environment.systemPackages = with pkgs; [
    cargo-edit
    openssl.dev
    pkgconfig
    rustup
    #sccache
  ];
}
