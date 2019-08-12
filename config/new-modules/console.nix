{ lib, config, pkgs, ... }:

with lib;

{
  #options.mine.console.enable = mkEnableOption "enable console config";

  options.mine.console.enable = mkOption {
    type = types.bool;
    default = true;
    description = "enable console config";
  };

  config = mkIf config.mine.console.enable {

    environment.pathsToLink = [ "/share/zsh" ];

    mine.vim.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };

    environment.systemPackages = with pkgs; [
      direnv
      gitFull
      tmux
      lsof
      pass
      gnupg
      unzip
      jq
      bc
      wget
      ripgrep
      file
      nmap
      traceroute
      nix-top
      fd
      gitAndTools.hub
      fzf
      sqliteInteractive
      gnumake
      whois
      aspellDicts.en
    ];

    users.defaultUserShell = pkgs.zsh;

    mine.userConfig = {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        userName = "Evan Stoll";
        userEmail = "evanjsx@gmail.com";
      };
    };
  };
}
