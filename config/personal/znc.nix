{ lib, config, ... }:

{

  mine.znc = {
    defaultNick = "evanjs";
    savebuffPassword = config.private.passwords.znc-savebuff;
    twitchPassword = config.private.passwords.twitchChatOauth;
    liberaPassword = config.private.passwords.libera;
  };

  services.znc = {
    config = {
      User.evanjs = {
        AltNick = "evanjs";
        RealName = "Evan Stoll";
        Pass.password = {
          Method = config.private.passwords.zncMethod;
          Salt = config.private.passwords.zncSalt;
          Hash = config.private.passwords.zncHash;
        };
        Network.rizon = lib.mkForce null;
        Network.twitch = lib.mkForce null;
        Network.libera = {
          Chan = {
            "#nixos" = { };
            "#home-manager" = { };
            "#nix-lang" = { };
            "#lorri" = { };
            "#nixos-rust" = { };
            "#nixos-chat" = { };
            "#nixos-emacs" = { };
            "##nixos-anime" = { };
          };
          JoinDelay = 2;
        };
          };
          JoinDelay = 2;
        };
      };
}
