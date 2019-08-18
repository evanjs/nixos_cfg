{ lib, config, ... }:

{

  mine.znc = {
    defaultNick = "evanjs";
    savebuffPassword = config.private.passwords.znc-savebuff;
    twitchPassword = config.private.passwords.twitchChatOauth;
    gitterPassword = config.private.passwords.gitterIrc;
  };

  services.znc = {
    config = {
      User.evanjs = {
        AltNick = "evanjs";
        RealName = "Evan Stoll";
        Network.rizon = lib.mkForce null;
        Network.twitch = lib.mkForce null;
        Network.freenode.Chan = {
          "#haskell" = { };
          "#nixos" = { };
          "##nixos-anime" = { };
          "#nixos-chat" = { };
          "#nix-lang" = { };
          "#nixos-borg" = { };
          "#nixos-dev" = { };
          "#minecraft" = { };
          "#home-manager" = { };
          "#haskell-ide-engine" = { };
        };
        Network.mozilla.Chan = {
          "#rust" = { };
          "#rust-beginners" = { };
        };
      };
    };
  };

}
