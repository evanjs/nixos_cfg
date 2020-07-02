{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.android;
in {
  options.mine.android = {
    enable = mkEnableOption "Android development configuration";
    extraPackages = mkOption {
      type = types.nullOr (types.listOf types.package);
      default = [];
      example = with pkgs; [ androidStudioPackages.beta ];
      description = "Extra packages to install";
    };

  };

  config = mkIf cfg.enable {
    nixpkgs.config = {
      android_sdk.accept_license = true;
    };

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
      androidStudioPackages.stable
    ] ++ cfg.extraPackages;
  };
}
