{ ... }:
let
  homeManager = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          on_unlock_cmd = "systemctl -- user restart noctalia.service";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on && systemctl --user restart xdg-desktop-portal-hyprland.service";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
