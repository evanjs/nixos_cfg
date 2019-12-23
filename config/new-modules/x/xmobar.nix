{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mine.xmobar;
  configFile = let
    fonts = lib.concatStringsSep "," [
      "Helvetica Neue LT Std,HelveticaNeueLT Std Lt Cn:style=47 Light Condensed,Regular:pixelsize=12"
      "FantasqueSansMono Nerd Font:pixelsize=12"
      "Noto Sans CJK JP,Noto Sans CJK JP Thin:style=Thin,Regular"
      "M+ 2p,M+ 2p light:style=light,Regular"
      "Noto Emoji:style=Regular:pixelsize=10"
    ];
  in pkgs.writeText "xmobar-config" ''
    Config {

    -- appearance
      font =         "xft:FiraCode Mono:size=8:bold:antialias=true"
    , bgColor = "#2b2b29"
    , fgColor = "#c3ae93"
    , alpha = 210
    , position = Bottom
    , border = TopB
    , borderColor =  "#646464"

    -- layout
    , sepChar =  "%"   -- delineator between plugin names and straight text
    , alignSep = "}{"  -- separator between left-right alignment
    , template = "%StdinReader% }{ %battery% | %multicpu% | %coretemp% | %memory% | %default:Master% | %dynnetwork% | %KTVC% | %date% || %kbd% "

   -- Southwest Michigan Regional Airport (KBEH)
   -- , template = "%StdinReader% }{ %battery% | %multicpu% | %coretemp% | %memory% | %default:Master% | %dynnetwork% | %KBEH% | %date% || %kbd% "

    -- general behavior
    , lowerOnStart =     True    -- send to bottom of window stack on start
    , hideOnStart =      False   -- start with window unmapped (hidden)
    , allDesktops =      True    -- show on all desktops
    , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
    , pickBroadest =     False   -- choose widest display (multi-monitor)
    , persistent =       True    -- enable/disable hiding (True = disabled)

    -- plugins
    --   Numbers can be automatically colored according to their value. xmobar
    --   decides color based on a three-tier/two-cutoff system, controlled by
    --   command options:
    --     --Low sets the low cutoff
    --     --High sets the high cutoff
    --
    --     --low sets the color below --Low cutoff
    --     --normal sets the color between --Low and --High cutoffs
    --     --High sets the color above --High cutoff
    --
    --   The --template option controls how the plugin is displayed. Text
    --   color can be set by enclosing in <fc></fc> tags. For more details
    --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
    , commands =

    -- weather monitor
    [ Run Weather "KTVC" [ "--template", "<skyCondition> | <fc=#4682B4><tempC></fc>°C | <fc=#4682B4><tempF></fc>°F | <fc=#4682B4><rh></fc>%"
    ] 36000

      -- network activity monitor (dynamic interface resolution)
      , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
      , "--Low"      , "1000"       -- units: B/s
      , "--High"     , "5000"       -- units: B/s
      , "--low"      , "darkgrey"
      , "--normal"   , "darkorange"
      , "--high"     , "darkgreen"
      ] 10

      -- cpu activity monitor
      , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
      , "--Low"      , "50"         -- units: %
      , "--High"     , "85"         -- units: %
      , "--low"      , "darkgreen"
      , "--normal"   , "darkorange"
      , "--high"     , "darkred"
      ] 10

      -- cpu core temperature monitor
      , Run CoreTemp       [ "--template" , "Temp: <core0>°C|<core1>°C"
      , "--Low"      , "70"        -- units: °C
      , "--High"     , "80"        -- units: °C
      , "--low"      , "darkgreen"
      , "--normal"   , "darkorange"
      , "--high"     , "darkred"
      ] 50

      -- memory usage monitor
      , Run Memory         [ "--template" ,"Mem: <usedratio>%"
      , "--Low"      , "20"        -- units: %
      , "--High"     , "90"        -- units: %
      , "--low"      , "darkgreen"
      , "--normal"   , "darkorange"
      , "--high"     , "darkred"
      ] 10

      -- battery monitor
      , Run Battery        [ "--template" , "Batt: <acstatus>"
      , "--Low"      , "10"        -- units: %
      , "--High"     , "80"        -- units: %
      , "--low"      , "darkred"
      , "--normal"   , "darkorange"
      , "--high"     , "darkgreen"

      , "--" -- battery specific options
      -- discharging status
      , "-o" , "<left>% (<timeleft>)"
      -- AC "on" status
      , "-O" , "<fc=#dAA520>Charging</fc>"
      -- charged status
      , "-i" , "<fc=#006000>Charged</fc>"
      ] 50

      -- time and date indicator
      --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
      , Run Date           "<fc=#ABABAB>%F (%a) %T</fc>" "date" 10

      -- keyboard layout indicator
      , Run Kbd            [ ("us(dvorak)" , "<fc=#00008B>DV</fc>")
      , ("us"         , "<fc=#8B0000>US</fc>")
      ]
      , Run StdinReader
      , Run Volume "default" "Master" [] 1
      ]
    }

    -- # vi:syntax=haskell
  '';
in {

  options.mine.xmobar = {
    command = mkOption {
      description = "The command to execute for xmobar";
      default = "${pkgs.haskellPackages.xmobar}/bin/xmobar ${configFile} $@";
    };
    enable = mkEnableOption "xmobar config";
  };

  config = mkIf cfg.enable {

    scripts = {

      power = ''
        ${pkgs.bc}/bin/bc <<< "scale=1; $(cat /sys/class/power_supply/BAT0/current_now)/1000000"
      '';
      batt = ''
        PATH="${pkgs.acpi}/bin:${pkgs.gawk}/bin:${pkgs.bc}/bin:$PATH"

        battstat=$(acpi -b | cut -d' ' -f3 | tr -d ',')

        charge_now=$(cat /sys/class/power_supply/BAT0/charge_now)
        charge_full=$(cat /sys/class/power_supply/BAT0/charge_full)

        charge=$(bc <<EOF
        scale=2
        100 * $charge_now / $charge_full
        EOF
        )

        chargeInteger=$(printf "%.0f\n" "$charge")


        if [ $chargeInteger -le 0 ]; then
          chargeInteger=0
        elif [ $chargeInteger -ge 100 ]; then
          chargeInteger=100
        fi

        if [ $chargeInteger -le 12 ]; then
          symbol=
        elif [ $chargeInteger -le 37 ]; then
          symbol=
        elif [ $chargeInteger -le 62 ]; then
          symbol=
        elif [ $chargeInteger -le 87 ]; then
          symbol=
        else
          symbol=
        fi

        red=$(( 255 - $chargeInteger * 255 / 100 ))
        green=$(( $chargeInteger * 255 / 100 ))

        case $battstat in
        Full)
          ;;
        Discharging)
          postfix="-$(date -u -d $(acpi -b | cut -d' ' -f5) +"%Hh%M")"
          ;;
        Charging)
          postfix="+$(date -u -d $(acpi -b | cut -d' ' -f5) +"%Hh%M")"
          ;;
        *)
          ;;
        esac

        printf "<fc=#%02x%02x00>%s%% %s</fc> (%s)\n" "$red" "$green" "$charge" "$symbol" "$postfix"
      '';
      playing = ''
        status="$(systemctl --user is-active music)"
        if [ $status = active ]; then
          echo 
        else
          echo 
        fi
      '';
    };
  };
}
