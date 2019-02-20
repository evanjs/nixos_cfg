{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    elixir

    elm2nix
    elm-github-install

  ];
}
