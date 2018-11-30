{ config, pkgs, ... }:
{
  boot.blacklistedKernelModules = [ "uvcvideo" ];
}
