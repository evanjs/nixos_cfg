with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";
  vimrcConfig = {
    customRC = (import ./rc.nix);
    vam = {
      knownPlugins = pkgs.vimPlugins;
      pluginDictionaries = (import ./plugin-dictionaries.nix);
    };
  };
}
