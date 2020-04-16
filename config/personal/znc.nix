{ lib, config, ... }:

{

  mine.znc = {
    defaultNick = "evanjs";
    savebuffPassword = config.private.passwords.znc-savebuff;
    twitchPassword = config.private.passwords.twitchChatOauth;
    gitterPassword = config.private.passwords.gitterIrc;
    freenodePassword = config.private.passwords.freenode;
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
        Network.freenode = {
          Chan = {
            "#xmonad" = { };
            "#haskell" = { };
            "#lorri" = { };
            "#nixos" = { };
            "##nixos-anime" = { };
            "#nixos-chat" = { };
            "#nixos-rust" = { };
            "#nixos-emacs" = { };
            "#nix-lang" = { };
            "#nixos-borg" = { };
            "#nixos-dev" = { };
            "#home-manager" = { };
            "#musnix" = { };
          };
          JoinDelay = 2;
        };
      };
    };
  };

}
