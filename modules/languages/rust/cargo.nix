{ config, pkgs, ... }:
{
  imports = [
    ../../unstable.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      cargo-bloat
      cargo-edit
      cargo-fuzz
      cargo-outdated
      cargo-tree
      cargo-update
      cargo-vendor
      unstable.carnix
    ];

    shellInit = ''
      # Add cargo/bin to the path to discover locally installed rust programs
      export PATH="$PATH:/home/evanjs/.cargo/bin"
    '';
  };
}
