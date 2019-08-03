{ config, ... }:
{
  programs = {
    skim = {
      enable = true;
      defaultCommand = "fd --type f";
      enableZshIntegration = true;
    };
  };
}
