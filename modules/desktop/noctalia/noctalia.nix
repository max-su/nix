{ ... }:
let
  homeManager = {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        widget.clock = {
          format = "{:%A} {:%H:%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
        };
        widget.media.max_length = 500;
        shell = {
          polkit_agent = true;
          screen_time_enabled = true;
          font_family = "Codelia Nerd Font";
          screenshot.show_cursor = true;
        };
        nightlight.enabled = true;
        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "suspend"
          ];
          pre_action_fade_seconds = 3.0;
        };
        bar.default = {
          position = "top";
          background_opacity = 0.0;
          radius = 80;
          margin_ends = 5;
          start = [ "session" "volume" ];
          center = [ "workspaces" "media" ];
          end = [ "tray" "clipboard" "control-center" "clock" ];
          font_family = "Codelia Nerd Font";
          capsule = true;
          capsule_fill = "#C86F87";
          capsule_opacity = 0.5;
        };
        location.auto_locate = true;
        weather.unit = "imperial";
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Rosé Pine";
        };
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
