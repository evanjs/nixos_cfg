{ config, lib, pkgs, inputs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  programs.hyprlock.enable = true;
  home-manager.users.evanjs = {
    programs.ghostty = {
      enable = true;
    };
    programs.wofi = {
      enable = true;
    };

    services.hypridle.enable = true;
    services.hyprpaper.enable = true;
    services.hyprsunset.enable = true;
    services.hyprpolkitagent.enable = true;
    services.hyprshell.enable = true;
    programs.hyprshot.enable = true;
    #home.pointerCursor = {
      #enable = true;
      #hyprcursor.enable = true;
    #};
    #home.stateVersion = "24.11";
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = false;
        enableXdgAutostart = true;
      };
      plugins = with pkgs.hyprlandPlugins; [
        hyprsplit
        hyprbars
        hyprexpo
        hyprfocus
        hyprscrolling
        hyprgrass
        hyprspace
      ];

      settings = {
        "$mod" = "SUPER";
        "$broswer" = "${pkgs.firefox}/bin/firefox";
        bind = [
          # Lock the screen using hyprlock
          "$mod, L, exec, hyprlock"

          # Switch to next window
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"

          # Toggle fullscreen mode for active window (on OR off)
          "$mod, F, fullscreen"

          # Set floating property of active window
          # Note: Not a toggle, use "settiled" to disable
          "$mod SHIFT, F, setfloating"

          # Set tiled property of active window
          # Note: Not a toggle, use "setfloating" to disable
          "$mod SHIFT, T, settiled"
          "$mod, Q, killActive"

          # Switch to workspace immediately to the left or right
          "$mod, left, workspace, -1"
          "$mod, right, workspace, +1"

          # Move window to workspace (and switch to it)
          "$mod CTRL, left, movetoworkspace, -1"
          "$mod CTRL, right, movetoworkspace, +1"

          # Move window to workspace (but don't switch to it)
          "$mod SHIFT CTRL, left, movetoworkspacesilent, -1"
          "$mod SHIFT CTRL, right, movetoworkspacesilent, +1"

          # Switch to workspace (matching the specified number)
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
        ];

        # Will also work when e.g. the lockscreen is active
        bindl = [
          # Binds for hyprshot variants (window, region, screen) 
          # Window screenshot, freeze, clipboard only
          # The command is: hyprshot --clipboard-only -m window --freeze
          "$mod SHIFT, w, exec, hyprshot --clipboard-only -m window --freeze"

          # Region screenshot, freeze, clipboard only
          # The command is: hyprshot --clipboard-only -m region --freeze
          "$mod SHIFT, r, exec, hyprshot --clipboard-only -m region --freeze"

          # Screen screenshot (full screen), freeze, clipboard only
          # The command is: hyprshot --clipboard-only -m screen --freeze
          "$mod SHIFT, s, exec, hyprshot --clipboard-only -m screen --freeze"          
        ];

        bindd = [
          "$mod, Q, Open terminal, exec, ${pkgs.ghostty}/bin/ghostty"

          "$mod, C, Open Emacs client, exec, ${pkgs.emacs}/bin/emacsclient -cn"

          "$mod, W, Open browser, exec, $browser"
          "$mod, E, Open browser, exec, firefox"
          
          "$mod CTRL, W, Restart waybar, exec, systemctl --user restart waybar"
        ];

        windowrulev2 = [

          # Ensure 1Password windows are displayed properly
          "size 50% 60%, title:(1Password)"
          "center, title:(1Password)"
        ];
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Breeze-Dark";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = {
        package = pkgs.kdePackages.breeze-icons;
        name = "Breeze-Dark";
      };
    };
  };
  #home-manager.users.root.home.stateVersion = "24.11";
  services.xserver.displayManager.defaultSession = "hyprland-uwsm";
  #services.displayManager.sddm = {
    #enable = true;
    #wayland.enable = true;
  #};

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    brightnessctl
    #hyprcursor
    #hyprlock
    #hypridle
    #hyprpaper
    #hyprsunset
    #hyprpolkitagent
  ];
}
