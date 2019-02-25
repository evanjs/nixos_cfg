{ config, pkgs, ... }:
{
  imports = [
    ./unstable.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      unstable.carnix
    ];

    #shellInit = ''
      #export PATH="$PATH:~/.cargo/bin"
      #export RUSTC_WRAPPER="sccache"
    #'';
    shellInit = ''
      export PATH="$PATH:~/.cargo/bin"
      export RUSTC_WRAPPER="sccache"
    '';
  };
}
