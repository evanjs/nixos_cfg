{ config, pkgs, ... }:
{

  imports = [
    ./haskell
    ./python
    ./rust
  ];

  environment.systemPackages = with pkgs; [
    go
    elixir

    elm2nix
    elm-github-install

  ];
}
