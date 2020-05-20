{ lib, config, pkgs, ... }:

with lib;

{
  options.mine.console.enable = mkOption {
    type = types.bool;
    default = true;
    description = "enable console config";
  };

  config = mkIf config.mine.console.enable {

    nixpkgs.config.packageOverrides = pkgs: {
      sudo = pkgs.sudo.override {
        withInsults = true;
      };
    };

    environment.pathsToLink = [ "/share/zsh" ];

    mine.vim.enable = true;

    programs.zsh = {
      autosuggestions.enable = true;
      enable = true;
      enableCompletion = true;
      ohMyZsh = { enable = true; };
    };

    programs.autojump = { enable = true; };

    environment.systemPackages = with pkgs; [
      direnv

      gitFull
      gitAndTools.hub
      gitAndTools.gh

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
      sqliteInteractive
      gnumake
      whois
      aspellDicts.en
      bat
      nix-index
      nix-prefetch-scripts
      ranger
      zstd
      tealdeer
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
      neofetch
      procs
      ytop
      termplay
    ];

    users.defaultUserShell = pkgs.zsh;

    mine.bash-insulter.enable = true;

    mine.userConfig = {
      programs = {
        broot = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
        direnv = { enable = true; };
        htop.enable = true;
      };
    };
  };
}
