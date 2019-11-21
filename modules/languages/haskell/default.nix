{ config, pkgs, ... }:
{
  imports = [
    ./hoogle
  ];

  environment = {
    systemPackages = with pkgs; [
      cabal-install
      #pkgs.stable.haskellPackages.jenkinsPlugins2nix
    ];

    shellInit = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
