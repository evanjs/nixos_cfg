{ lib, config, pkgs, ... }:

with lib;
let
  packages = with pkgs; [
    direnv

    gitFull
    gitAndTools.hub
    gitAndTools.gh
    gitAndTools.delta

    _1password
    aspellDicts.en
    bat
    bc
    nixpkgs-unstable.bingrep
    cht-sh
    cv
    diskonaut
    du-dust
    fd
    file
    gnumake
    gnupg
    hashcat
    hwinfo
    jq
    lsof
    neofetch
    nix-index
    nix-prefetch-scripts
    nix-top
    nmap
    openssl
    pass
    pciutils
    procs
    pwgen
    ranger
    ripgrep
    ripgrep-all
    sd
    sqliteInteractive
    tealdeer
    termplay
    tmux
    traceroute
    unzip
    usbutils
    wget
    whois
    ytop
    zstd

    nodePackages.insect
  ];
  hm = (import ./console-hm.nix { inherit pkgs config lib; });
  cfg = config.mine.console;
in
  {
    options.mine.console = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "enable console config";
      };
    };

    config = mkIf cfg.enable (mkMerge [
      {
        nixpkgs.config.packageOverrides = pkgs: {
          sudo = pkgs.sudo.override {
            withInsults = true;
          };
        };

        environment.pathsToLink = [ "/share/zsh" ];

        mine.vim.enable = true;


        users.defaultUserShell = pkgs.zsh;

        mine.bash-insulter.enable = true;
        mine.userConfig = {
          inherit (hm) programs;
        };
        environment.systemPackages = packages;
        programs = {
          autojump.enable = true;
          zsh = {
            enable = true;
            autosuggestions.enable = true;
            ohMyZsh.enable = true;
          };
        };
      }
    ]);
  }

