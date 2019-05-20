{ config, pkgs, ... }:
{
  imports = [
    ../../unstable.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      unstable.cargo-bloat
      cargo-edit
      cargo-fuzz
      unstable.cargo-outdated
      cargo-tree
      cargo-update
    ];

    shellInit = ''
      # Add cargo/bin to the path to discover locally installed rust programs
      export PATH="$PATH:/home/evanjs/.cargo/bin"
    '';
  };
}
