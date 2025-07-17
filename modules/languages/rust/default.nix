{ config, pkgs, ... }:
{
  imports = [
    ./cargo.nix
    ./cross.nix
    ./documentation
  ];

  environment.systemPackages = with pkgs; [
    openssl.dev
    pkg-config
    rust-with-extensions.base
  ];
}
