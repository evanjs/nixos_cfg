# configuration.nix
{ config, pkgs, lib, inputs, ... }:
rec {
  imports = [
    ../../../config
    ./hardware-configuration.nix
    #./eww.nix
    ./hyprland.nix
    #./plasma.nix
    ./greetd.nix
    ./waybar.nix
  ];

  system.stateVersion = "25.05";
  #home-manager.users.evanjs.home.stateVersion = "25.05";

  #boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ???
  #mine.xUserConfig.accounts.calendar.basePath = ".calendar";
  home-manager.users.evanjs.accounts.calendar.basePath = ".calendar";
  home-manager.users.root.accounts.calendar.basePath = ".calendar";

  #mine.x.enable = false;
  mine.wm.enable = true;
  mine.dev.haskell.enable = false;
  mine.taffybar.enable = false;

  mine.userConfig = {
    programs = {
      mu = {
        enable = true;
      };
    };
    services = {
      pantalaimon = {
        # olm has been amrked as insecure
        # this effectively renders most (?) matrix clients in-tree as "broken" unless the insecure package is acknowledged/allowed/installed
        # See also: https://github.com/NixOS/nixpkgs/pull/443522
        enable = false;
        settings = {
          Default = {
            #LogLevel = "Debug";
            SSL = true;
          };
          local-matrix = {
            Homeserver = "https://matrix.org";
            ListenAddress = "127.0.0.1";
            ListenPort = 8008;
          };
        };
      };
    };
  };

  i18n = {
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
 
  # RDP
  services.xrdp.enable = true;

  services.sshd.enable = true;

  # Networking
  networking.hostName = "alienix";
  networking.networkmanager.enable = true;

  hardware.enableRedistributableFirmware = true;

  mine.hardware = {
    battery = false;
    cpuCount = 8;
    swap = false;
    touchpad = false;
    wlan = true;
    audio = true;
  };

  mine.enableUser = true;
  mine.profiles.desktop.enable = true;
  mine.emacs.enable = lib.mkForce false;
  mine.tex.enable = true;
  mine.obsidian.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--accept-routes"
    ];
  };

  boot = {
    kernelParams = [ "acpi_enforce_resources=lax" ];
    kernelModules = [
      "i2c-dev"
      "i2c-piix4"
      #"acpi_call"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      6742
    ];
  };

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  hardware.i2c = {
    enable = true;
  };

  # Users
  users.users.evanjs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "i2c" "plugdev" "usb" ];
    shell = pkgs.nushell;
  };

  security.pam.services.kwallet.enableKwallet = true;

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  boot.extraModulePackages = with pkgs.linuxPackages_latest; [ acpi_call ];

  services.rustdesk-server = {
    enable = true;

    openFirewall = true;
    signal.relayHosts = [ "127.0.0.1" ];
  };
  

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.system = "x86_64-linux";

  programs.bat.extraPackages = with pkgs.bat-extras; [
    batman
  ];

  services.gnome.gnome-remote-desktop.enable = true;

  environment.systemPackages = with pkgs; [
    neovim git curl
    fd ripgrep bat
    emacs
    i2c-tools

    steam-rom-manager
    rustdesk-server
    polychromatic

    slack

    obsidian
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.acpid = {
    enable = true;
  };

  nix = {

    settings = {
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };
}
