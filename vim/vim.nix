with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = (import ./rc.nix);
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
  vimrcConfig.vam.pluginDictionaries = (import ./plugin-dictionaries.nix);
}
