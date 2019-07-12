{ config, pkgs, ... }:

with config.lib.email;
with config.accounts.email;
{
  programs.mbsync = {
    enable = true;
    extraConfig = ''
      CopyArrivalDate yes
      Create Both
      Expunge Both
      Remove None
      SyncState *
    '';
  };

  services.mbsync = {
    enable = true;
    verbose = false;
    frequency = "*:0/15"; # Every 15m
    preExec = ''
      ${pkgs.coreutils}/bin/mkdir -p ${concatAccounts " " (i: v: "${maildirBasePath}/${v}")}
    '';
  };
}
