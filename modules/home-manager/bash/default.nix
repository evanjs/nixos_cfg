{ config, ... }:
{
  imports = [
    ./powerline.nix
  ];
  home-manager.users.evanjs = {
    programs.bash = {
      enable = true;
    };
  };
}
