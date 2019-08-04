{ config, pkgs, ... }:
{
  home-manager.users.evanjs = {
    services.compton = {
      backend = "glx";
      blur = true;
      blurExclude = [
        "class_g = 'slop'"
        "class_i = 'taffybar'"
        "class_i = 'xmobar'"
      ];
      enable = true;
      extraOptions = ''
        unredir-if-possible   = true;
        use-ewmh-active-win   = true;
        detect-transient      = false;
        xinerama-shadow-crop  = true;
        blur-method = "kawase";
        blur-strength = 50
        detect-rounded-corners = true;
        shadow-ignore-shaped = true;
        sw-opti = false;
        wintypes:
        {
          tooltip = {
            # fade: Fade the particular type of windows.
            fade = true;
            # shadow: Give those windows shadow
            shadow = false;
            # opacity: Default opacity for the type of windows.
            opacity = 0.85;
            # focus: Whether to always consider windows of this type focused.
            focus = true;
          };
        };
      '';
      fade = true;
      inactiveOpacity = "0.9";
      shadow = true;
      fadeDelta = 4;
      fadeExclude = [
        "name = 'Screenshot'"
        "class_g = 'slop'"
      ];
      shadowExclude = [
        "name = 'Screenshot'"
        "class_g = 'slop'"
        "name = 'Notification'"
        "window_type *= 'menu'"
        "name ~= 'Firefox\$'"
        "focused = 1"
      ];

      vSync = "opengl-swc";
    };
  };
}
