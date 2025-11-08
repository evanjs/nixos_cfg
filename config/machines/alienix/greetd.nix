{ config, lib, pkgs, inputs, ... }:
let
  # Create a minimal hyprland config file just for the greeter
  hyprland-greeter-conf = pkgs.writeText "hyprland-greeter.conf" ''
    # Start gtkgreet. When gtkgreet exits (on login), exit this Hyprland instance.
    exec-once = ${pkgs.gtkgreet}/bin/gtkgreet; hyprctl dispatch exit
    '';
in
  {
  # The greeter user still needs access to video hardware
  users.users.greeter.extraGroups = [ "video" ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Tell greetd to launch Hyprland using our special config
        command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprland-greeter-conf}";
        user = "greeter";
      };

      # Autologin
      #initial_session = {
        #command = "${pkgs.hyprland}/bin/Hyprland";
        ##user = "\${user}";
        #user = "evanjs";
      #};
    };
  };

  # Ensure the necessary packages are in the system path
  environment.systemPackages = with pkgs; [
    gtkgreet
  ];

  environment.etc."greetd/environments".text = let
    environments = [
      {
        name = "Hyprland";
        condition = with config.programs.hyprland; enable && !withUWSM;
      }
      {
        name = "uwsm start hyprland-uwsm.desktop";
        condition = with config.programs.hyprland; enable && withUWSM;
      }
      {
        name = "sway";
        condition = config.programs.sway.enable;
      }
    ];
  in
  builtins.concatStringsSep "\n" (map (env: env.name) (builtins.filter (env: env.condition) environments));
}
