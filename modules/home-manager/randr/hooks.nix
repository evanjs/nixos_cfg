{ config, pkgs, ... }:
{
  programs = {
    autorandr = {
      hooks = {
        postswitch = {
          "change-dpi" = ''
            case "$AUTORANDR_CURRENT_PROFILE" in
            default)
            DPI=196
            ;;
            *)
            echo "Unknown profile: $AUTORANDR_CURRENT_PROFILE"
            exit 1
            esac

            echo "XFt.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
          '';
        };
      };
    };
  };
}
