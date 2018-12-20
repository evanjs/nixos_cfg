[
  { name  =  "youcompleteme"; }
  { names = [ "nerdcommenter" "vim-autoformat" "vim-airline" ]; }
  { name  = "LanguageClient-neovim"; }
  { name = "fugitive"; }

  # only load for TOML files
  { name = "vim-toml"; filename_regex = "^\\.toml$"; }

  # only load for QML files
  { name = "vim-qml"; filename_regex  = "^\\.qml$"; }

  # only load for Haskell files
  { name = "haskell-vim"; filename_regex = "^\\.hs$"; }

  # only load for Nix files
  { name = "vim-nix"; filename_regex = "^\\.nix$"; }
]
