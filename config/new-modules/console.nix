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
      pwgen
      du-dust
      multipath-tools
      nixpkgs-unstable.bingrep
      pciutils
      hwinfo
      hashcat
      openssl
    ];

    users.defaultUserShell = pkgs.zsh;

    mine.userConfig = {
      programs = {
        direnv = {
          enable = true;
        };
        htop.enable = true;
      };
    };
  };
}
