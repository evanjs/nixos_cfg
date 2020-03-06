{ config, pkgs, ... }:
{
  nixpkgs.config = {
    android_sdk.accept_license = true;
  };

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    androidStudioPackages.stable
    androidStudioPackages.beta
  ];
}
