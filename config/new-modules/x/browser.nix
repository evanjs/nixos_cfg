{ lib, config, pkgs, ... }:
with lib;

{

  options.mine.firefox = mkOption {
    type = types.package;
    description = "Default firefox";
  };

  options.mine.chromium = mkOption {
    type = types.package;
    description = "Default chromium";
  };

  config = {
    environment.systemPackages = mkIf config.services.xserver.enable [ config.mine.chromium config.mine.firefox ];
    nixpkgs.config.firefox.enableBrowserpass = true;

    # Needed for services that use DRM for streaming, such as VRV, Netflix, etc
    nixpkgs.config.chromium.enableWideVine = true;
    
    # Note: extensions don't work with -bin versions of firefox
    mine.firefox = pkgs.firefox;
    mine.chromium = pkgs.chromium;
  };

}

