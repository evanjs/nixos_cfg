{ pkgs, config, ... }:
let


  #pkgs = import <nixpkgs> { overlays = [ ./custom-packages.nix ]; };

  jetPkgs = with pkgs.jetbrains; [
    clion
    #idea-ultimate
    jdk
    phpstorm
    pycharm-professional
    #webstorm
  ];


in
  {
          # List packages installed in system profile. To search, run:
          # $ nix search wget
          environment.systemPackages = with pkgs; [
            # system utilities
            ag
            autojump
            wget
            jq
            pdfgrep
            zstd
            multitail
            #cachix
            screen
            pandoc

            # rust utilities
            ripgrep
            fd

            btrfs-progs
            filelight
            qdirstat

            # media

            # editors
            (import ./vim/vim.nix)
            (import ./vim/neovim.nix)

            # browsers
            chromium
            firefox

            # dev
            gitAndTools.gitFull


            # compilers / toolchains
            stack

            gcc
            binutils
            gnumake
            openssl.dev
            systemd.dev
            pkgconfig

            # nix
            nix
            nox

            # xmonad
            xmonad-log

            # Setup: Encountered missing dependencies:
            # xmonad >=0.11 && <0.13, xmonad-contrib >=0.11 && <0.13
            #haskellPackages.xmonad-contrib-gpl

            # misc DM/DE
            trayer
            rofi
            xscreensaver
            maim
            xtrlock-pam
            xclip
            xorg.xbacklight
            xdotool

            # terminals
            kitty

            # vcs
            #gitkraken

            # pass management
            _1password

            #ghcPkgs

            #wpsoffice
            #(pkgs.libsForQt5.callPackage qrbooru {})
            #qrbooru
          ]
          ++ jetPkgs
          ;
        }
