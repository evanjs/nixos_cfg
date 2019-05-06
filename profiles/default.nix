{ config, pkgs, ... }:
{
  imports = [
    #../options
    ../overlays
  ]
  ++ (if (builtins.pathExists(./containers)) then [ ./containers ] else [])
  ++ [
    ../modules/cachix.nix
    ../modules/editors.nix
    ../modules/i18n.nix
    ../modules/network.nix
    ../modules/nix.nix
    ../modules/users.nix
    ../modules/vim
  ];

  environment.systemPackages = with pkgs; [
    ag
    wget
    jq
    pdfgrep
    zstd
    multitail
    screen
    pandoc
    file
    unixtools.netstat
    neofetch
    nget # lazily query nix package attributes
    du-dust # du, now with more oxygen!
    lm_sensors

    fbterm

    # rust utilities
    ripgrep
    fd

    # disk utilities
    btrfs-progs

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

    # terminals
    kitty

    # password management
     _1password # currently broken

  ];

  #
  # Misc settings
  # -------------
  #

  # mount /tmp as tmpfs on boot
  # this will prevent us from compiling and performing other
  # heavy operations on the drive whenever possible
  boot.tmpOnTmpfs = true;

  # Set your time zone.
  time.timeZone = "America/Detroit";
  services.ntp.enable = true;

  environment.variables.EDITOR = "vim";

  programs.bash.enableCompletion = true;

  security.sudo.enable = true;

  environment.pathsToLink = [ "/share" ];

  #
  # User profile
  # ------------
  #

  environment.extraInit = ''
    [ -e "$HOME/.profile" ] && source "$HOME/.profile"
  '';

  #
  # nix / nixpkgs configuration
  # ---------------------------
  #

  #nixpkgs.config.allowUnfree = true;

  #
  # Services
  # --------
  #

  programs.autojump.enable = true;

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
}
