{ config, ... }:
{
  programs = {
    lsd = {
      enableAliases = true;
      enable = true;
    };
  };
}
