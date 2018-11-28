[
  { name  =  "youcompleteme"; }
  { names = [ "nerdcommenter" "vim-autoformat" "vim-airline" ]; }
  { name  = "LanguageClient-neovim"; }

  # only load for toml files
  { name = "vim-toml"; filename_regex = "^.toml\$"; }

  # only load for qml files
  { name = "vim-qml"; filename_regex  = "^.qml\$"; }

  # only load for haskell files
  { name = "haskell-vim"; }
]
