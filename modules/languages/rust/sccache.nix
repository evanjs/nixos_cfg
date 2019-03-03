{ config, pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      sccache
    ];

    shellInit = ''
      export RUSTC_WRAPPER="sccache"
    '';
  };
}
