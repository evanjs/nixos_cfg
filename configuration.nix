# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, options, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
    #./avahi.nix
    ./bash.nix
    ./cachix.nix
    ./devpkgs.nix
    ./editors.nix
    ./env.nix
    ./fonts.nix
    ./games.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./haskell.nix
    ./hie.nix
    ./hoogle.nix
    ./i18n.nix
    ./iOS.nix
    ./nocam.nix
    #./overlays-compat
    ./power.nix
    ./python.nix
    ./rust.nix
    ./samba.nix
    ./services/services.nix
    ./sound.nix
    ./steam.nix
    ./syspkgs.nix
    ./theme.nix
    ./unstable.nix
    ./virtualization
    ./web.nix
    ./x.nix
    ./xrdp.nix
  ];


  nix.nixPath = 
  options.nix.nixPath.default ++
  [
    "ssh-config-file=/home/evanjs/.ssh/config"
    "ssh-auth-sock=/run/user/1000/ssh-agent"
  ];
    system.autoUpgrade = {
      enable = true;
      dates = "04:40";
    };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # mount /tmp as tmpfs on boot
  # this will prevent us from compiling and performing other
  # heavy operations on the drive whenever possible
  boot.tmpOnTmpfs = true;

  # Set your time zone.
  time.timeZone = "America/Detroit";
  services.ntp.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 8000 8080 8089 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evanjs = {
    home = "/home/evanjs";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };


  boot.kernelPackages = pkgs.unstable-small.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nixentoo";

  hardware.cpu.intel.updateMicrocode = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

  #latest_kernel = {
    #enable = true;
  #};

  programs.vim.defaultEditor = true;

  #nix.nixPath =
    #options.nix.nixPath.default ++
    #[ "nixpkgs-overlays=/etc/nixos/overlays-compat" ]
    #;
    #nixpkgs.overlays = let dir = ./overlays; in map (e: import "${dir}/${e}") (builtins.attrNames (builtins.readDir dir));
    #nixpkgs.overlays = [ "overlay" ];
  }
