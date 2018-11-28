with import <nixpkgs> {};

neovim.override {
  configure = {
    customRC = (import ./rc.nix);
    vam = {
      knownPlugins = pkgs.vimPlugins;
      pluginDictionaries = (import ./plugin-dictionaries.nix);
    };
  };
}
