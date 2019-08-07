{ config, pkgs, lib, ... }:
with lib;
with builtins;
{
  environment.systemPackages = with pkgs; [
    neovim
  ];

  nixpkgs.config.packageOverrides = old: {
    neovim = old.neovim.override {
      viAlias = true;
      vimAlias = true;
      withPython3 = true;

      configure = {
        customRC = toString (builtins.attrValues (pkgs.nix-helpers.importFrom ./config));
        vam = {
          knownPlugins = pkgs.vimPlugins;
          pluginDictionaries = (import ./plugin-dictionaries.nix);
        };
      };
    };
  };
}
