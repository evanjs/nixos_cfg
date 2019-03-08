with import <nixpkgs> {};

neovim.override {
  viAlias = true;
  vimAlias = true;
  withPython3 = false;

  configure = {
    customRC = (import ./rc.nix);
    vam = {
      knownPlugins = pkgs.vimPlugins;
      pluginDictionaries = (import ./plugin-dictionaries.nix);
    };
  };
}
