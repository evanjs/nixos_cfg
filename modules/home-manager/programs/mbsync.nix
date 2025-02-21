{ config, pkgs, lib, ... }:

with config.home-manager.users.evanjs.lib.email;
with config.home-manager.users.evanjs.accounts.email;
let
  #isync-oauth2 = with pkgs; buildEnv {
    #name = "isync-oauth2";
    #paths = [ isync ];
    #pathsToLink = [ "/bin" ];
    #nativeBuildInputs = [ makeWrapper ];
    #postBuild = ''
      #wrapProgram "$out/bin/mbsync" \
        #--prefix SASL_PATH : "${cyrus_sasl}/lib/sasl2:${cyrus-sasl-xoauth2}/lib/sasl2"
    #'';
  #};
  isync-oauth2 = (pkgs.isync.override {
    withCyrusSaslXoauth2 = true;
  });
in
{
  home-manager.users.evanjs =  {
    home.packages = with pkgs; [
      oauth2ms
    ];
    programs.mbsync = {
      enable = lib.mkDefault true;
      package = isync-oauth2;
      extraConfig = ''
        AuthMech XOAUTH2
        CopyArrivalDate yes
        Create Both
        Expunge Both
        Remove None
        SyncState *
      '';
    };

    services.mbsync = {
      enable = lib.mkDefault true;
      verbose = lib.mkDefault false;
      frequency = lib.mkDefault "*:0/15"; # Every 15m
      preExec = ''
        ${pkgs.coreutils}/bin/mkdir -p ${concatAccounts " " (i: v: "${maildirBasePath}/${v}")}
      '';
    };
  };
}
