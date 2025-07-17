{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      lsd = {
        #enableAliases = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enable = true;
      };
    };
  };
}
