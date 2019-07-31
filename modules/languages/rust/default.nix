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
    rust-with-extensions.std-only
  ];
}
