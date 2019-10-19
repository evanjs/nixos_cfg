{ config, pkgs, ... }:
{
  imports = [
    ../../channels.nix
  ];

  environment = {
    shellInit = ''
      # Add cargo/bin to the path to discover locally installed rust programs
      export PATH="$PATH:/home/evanjs/.cargo/bin"
    '';
  };
}
