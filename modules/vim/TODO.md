# TODO
## Modularize plugin-dictionaries.nix
  - Potential Solution:
    - Create folder "Plugins"
    - Define groups of plugins across multiple files
    - Concat files in plugins folder for vam.pluginDictionaries
## Enable Python3 for neovim
  - Currently, if `withPython3` is not set to false for neovim, YouCompleteMe will not function
  - Setting `withPython3` to false fixes the issue
  - Is it possible to enable python3 support for YouCompleteMe with neovim?
