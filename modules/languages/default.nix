{ config, pkgs, ... }:
{

  imports = [
    ./elm
    ./haskell
    ./python
    ./rust
  ];

  environment.systemPackages = with pkgs; [
    go
    elixir
  ];
}
