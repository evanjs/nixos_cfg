{ config, pkgs, ... }:
{
  imports = [
    ./db/postgresql.nix
  ];

  environment.systemPackages = with pkgs.python36Packages; [
    scrapy
    sqlalchemy
  ];
}
