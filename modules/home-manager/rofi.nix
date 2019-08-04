{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      rofi = {
        enable = true;
        theme = "Monokai";
      };
    };
  };
}
