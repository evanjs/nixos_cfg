{ config, pkgs, ... }:
{
  imports = [
    ./hie.nix
    ./hoogle
    ../../channels.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      cabal-install
      pkgs.unstable-small.cabal2nix
      #pkgs.stable.haskellPackages.jenkinsPlugins2nix
    ];

    shellInit = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
