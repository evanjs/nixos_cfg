{ config, ... }:
{
  home-manager.users.evanjs = {
    programs.bash = {
      enable = true;
    };
  };
}
