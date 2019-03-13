{ config, ... }:
{
  # This file contains packages and settings related to documentation
  # At the moment, this is only relevant for other development tools and settings

  imports = [
    ./api_docs.nix
  ];
}
