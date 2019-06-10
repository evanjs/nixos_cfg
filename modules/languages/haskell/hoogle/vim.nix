{ config, pkgs, ... }:
{
  nixpkgs.config.packageOverrides = old: {
    neovim = old.neovim.override {
      configure = {
        vam.override = ovamm: {
          pluginDictionaries = ovamm.pluginDictionaries // (import ./plugin-dictionaries.nix);
        };
      };
    };
  };
}
