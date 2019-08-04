{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      skim = {
        enable = true;
        defaultCommand = "fd --type f";
        enableZshIntegration = true;
      };
    };
  };
}
