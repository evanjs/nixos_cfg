{ config, pkgs, ... }:

with config.lib.email;
with config.accounts.email;

let

  mkAccountFile = name:
    let acct = builtins.getAttr name accounts; in
    pkgs.writeText "${name}_account" ''
      set from = "${acct.address}"
      set hostname = "gmail.com"
      set sendmail = "${pkgs.msmtp}/bin/msmtp -a ${name} --tls-trust-file=${acct.smtp.tls.certificatesFile}"
      set spoolfile = +${name}/Inbox
      set mbox      = +${name}/All
      set record    = +${name}/Sent
      set postponed = +${name}/Drafts
      set trash     = +${name}/Trash
      mailboxes $spoolfile $record $postponed $trash $mbox +${name}/Spam
      macro index,pager m? "<save-message>?<enter>" "Move message to mailbox"
      macro index,pager ma "<save-message>$mbox<enter>" "Move message to archive"
      macro index,pager mi "<save-message>$spoolfile<enter>" "Move message to inbox"
    '';

  mkFolderHook = name: shortcut: ''
    folder-hook =${name}/* source ${mkAccountFile name}
    macro index,pager ${shortcut} "<change-folder>=${name}/Inbox<enter><check-stats>"
    push ${shortcut}
  '';

  mailcap = pkgs.writeText "mailcap" ''
    image/jpg; ${./view_attachment.sh} %s jpg
    image/jpeg; ${./view_attachment.sh} %s jpg
    image/pjpeg; ${./view_attachment.sh} %s jpg
    image/png; ${./view_attachment.sh} %s png
    image/gif; ${./view_attachment.sh} %s gif
    application/pdf; ${./view_attachment.sh} %s pdf
    text/html; ${./view_attachment.sh} %s html
    application/octet-stream; ${./view_attachment.sh} %s "-"
  '';

in

{
  home = {
    packages = with pkgs; [ neomutt urlview ];
    file.".urlview".text = "COMMAND xdg-open %s";
  };

  xdg.configFile."mutt/muttrc".text = ''
    ${builtins.readFile ./colors}
    ${builtins.readFile ./unbindings}
    ${builtins.readFile ./bindings}
    ${builtins.readFile ./muttrc}
    set history_file = "${config.home.homeDirectory}/.cache/mutt/history"
    set mailcap_path = "${mailcap}"
    set folder = "${maildirBasePath}"
    ${concatAccounts "\n" (i: v: mkFolderHook v "<F${toString i}>")}
  '';
}