{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      lsd = {
        enableAliases = true;
        enable = true;
      };
    };
  };
}
