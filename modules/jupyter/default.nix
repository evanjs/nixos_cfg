{ config, pkgs, lib, ... }:
with lib;
{
  services.jupyter = {
    enable = true;
    password = readFile ./pass;
  };
}
