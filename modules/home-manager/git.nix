{ config, ... }:
{
  home-manager.users.evanjs = {
    programs = {
      git = {
        enable = true;
        userEmail = "evanjsx@gmail.com";
        userName = "Evan Stoll";
        ignores = (import ./git/ignores_formatted.nix);
      };
    };
  };
}
