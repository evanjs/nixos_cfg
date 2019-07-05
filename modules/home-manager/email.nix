{ config, pkgs, lib, ... }:

let

  mkGmailAccount = { name, address, primary ? false }: {
    inherit primary address;
    realName = "Evan Stoll";
    flavor = "gmail.com";
    #passwordCommand = "PASSWORD_STORE_DIR=${config.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass email/${name} | head -n1";
    passwordCommand = if lib.pathExists ../../passwords/gmail then "cat ${../../passwords/gmail}" else "";
    maildir.path = name;
    smtp.tls.useStartTls = true;
    imap.tls.useStartTls = false;
    msmtp.enable = true;
    mbsync = {
      enable = true;
      create = "both";
      expunge = "both";
      patterns = ["![Gmail]*"];
      extraConfig.channel = {
        CopyArrivalDate = "yes";
      };
    };
  };

  mkOffice365Account = { name, address, primary ? false }: {
    inherit primary address;
    userName = address;
    realName = "Evan Stoll";
    #passwordCommand = "PASSWORD_STORE_DIR=${config.lib.sessionVariables.PASSWORD_STORE_DIR} ${pkgs.pass}/bin/pass email/${name} | head -n1";
    passwordCommand = if lib.pathExists ../../passwords/rjg then "cat ${../../passwords/rjg}" else "";
    maildir.path = name;
    smtp = {
      host = "smtp.outlook365.com";
      tls.useStartTls = true;
    };
    imap = {
      host = "outlook.office365.com";
      tls.useStartTls = false;
    };
    msmtp.enable = true;
    mbsync = {
      enable = true;
      create = "both";
      expunge = "both";
      #patterns = ["![Outlook]*"];
      extraConfig.channel = {
        CopyArrivalDate = "yes";
      };
    };
  };

  #accounts = lib.mkMerge [
    accounts = {
    gmail = (mkGmailAccount ({ name = "gmail"; primary = true; address = "evanjsx@gmail.com"; }));
    rjg = (mkOffice365Account ({ name = "rjg"; primary = false; address = "evan.stoll@rjginc.com"; }));
    #(builtins.mapAttrs (k: v: mkGmailAccount (v // { name = k; })) {
      #gmail = { primary = true; address = "evanjsx@gmail.com"; };
    #})
    #(builtins.mapAttrs (k: v: mkOffice365Account (v // { name = k; })) {
      #rjg = { primary = false; address = "evan.stoll@rjginc.com"; };
    #})
  };

  concatAccounts = separator: fn:
  builtins.concatStringsSep separator
  (pkgs.lib.imap1 fn (builtins.attrNames accounts));
in

  {
    imports = [ ./programs/mbsync.nix ./programs/neomutt ];

    lib.email = { inherit concatAccounts; };

    programs.msmtp.enable = true;

    accounts.email = {
      inherit accounts;
      maildirBasePath = "${config.home.homeDirectory}/mail";
    };
  }
