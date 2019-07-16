{ config, ... }:
{
  imports = [
    ./powerline.nix
  ];

  programs.bash = {
    enable = true;
  };
}
