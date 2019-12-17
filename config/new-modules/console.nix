{ lib, config, pkgs, ... }:

with lib;

{
  options.mine.console.enable = mkOption {
    type = types.bool;
    default = true;
    description = "enable console config";
  };

  config = mkIf config.mine.console.enable {

    environment.pathsToLink = [ "/share/zsh" ];

    mine.vim.enable = true;

    programs.zsh = {
      autosuggestions.enable = true;
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
      };
    };

    programs.autojump = {
      enable = true;
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
      ripgrep-all
      sd
      file
      nmap
      traceroute
      nix-top
      fd
      gitAndTools.hub
      sqliteInteractive
      gnumake
      whois
      aspellDicts.en
      bat
      nix-index
      nix-prefetch-scripts
      ranger
      zstd
      tldr
      usbutils
      cht-sh
      cv
      _1password
      du-dust
      multipath-tools
    ];

    users.defaultUserShell = pkgs.zsh;

    mine.userConfig = {
      # TODO: break direnv out into a module with options for e.g. python, etc
      programs = {
        direnv = {
          enable = true;
        };
      };
    };
  };
}
