{ config, pkgs, ... }:
let
  jetPkgs = with pkgs.unstable.jetbrains; [
    clion
    idea-ultimate
    jdk
    phpstorm
    pycharm-professional
    webstorm
  ];

in
  {
    imports = [
      ./design.nix
      ./media.nix
      ./notifications.nix
      ./qt.nix
      ./social.nix
      ./unstable.nix
      ./wireshark.nix
    ];
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
            cachix
            screen
            pandoc

            # rust utilities
            ripgrep
            fd

            # disk utilities
            btrfs-progs
            filelight
            qdirstat

            # media
            ## photo
            feh
            ## video
            mplayer

            # editors
            (import ./vim/vim.nix)
            (import ./vim/neovim.nix)

            # browsers
            #unstable.chromiumDev
            chromium
            firefox

            # dev
            gitAndTools.gitFull


            # compilers / toolchains
            rustup
            stack

            gcc
            binutils
            gnumake
            openssl.dev
            systemd.dev
            pkgconfig

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
            gitkraken

            # pass management
            _1password

            #ghcPkgs
          ]
          ++ jetPkgs
          ;
        }
