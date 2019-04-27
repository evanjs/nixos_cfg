{ config, pkgs, ... }:
{
  imports = [
    ../../unstable.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      unstable.carnix
    ];

    shellInit = ''
      export PATH="$PATH:/home/evanjs/.cargo/bin"
    '';
  };
}
