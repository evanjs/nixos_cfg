{ config, pkgs, libs, headless ? false, ... }:
with lib;
{
  options.headless.enable = mkEnableOption "Headless configuration";

  config = if config.headless.enable then {
    services.xserver.enable = true;
  } else {

  };
}

