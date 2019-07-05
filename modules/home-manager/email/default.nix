{ config, pkgs, lib, ... }:
let
  pass = "${pkgs.pass}/bin/pass";
  head = "${pkgs.coreutils}/bin/head";
  grep = "${pkgs.ripgrep}/bin/rg";
  sed = "${pkgs.gnused}/bin/sed";
  getPassword = service: "${pass} show '${service}' | ${head} -n 1";
  getAppPassword = service: "${pass} show '${service}' | ${grep} \"App Password\" | ${sed} 's/.*: //'";
in
  {
    imports = [
      ./gmail
      ./rjg
    ];

    accounts.email = {
      maildirBasePath = "mail";
    };

    home.packages = with pkgs; [
      neomutt
      lmdb
      kyotocabinet
    ];
    home.file = {
      ".mutt/mailcap".text = ''
        text/html; ${pkgs.w3m}/bin/w3m -dump %s; nametemplate=%s.html; copiousoutput
      '';
      ".config/neomutt/neomuttrc".text = lib.readFile ./neomutt/neomuttrc;
    };

    programs = {
      notmuch = {
        enable = true;
    };

    afew = {
      enable = true;
    };

    alot = {
      enable = true;
    };

    mbsync = {
      enable = true;
    };

    msmtp = {
      enable = true;
    };
  };

  services = {
    mbsync = {
      enable = true;
    };
  };
}
