# This module also carries the burden of launching noctalia so as to avoid race conditions with
# setting wallpapers
#
# Every new host with different monitor configurations needs to copy this module and update
# the wallpapers correspondingly
{ self, ... }:
let
  homeManagerEllinia = {
    lib,
    ...
  }:
  {
    programs.noctalia.settings.wallpaper = {
      enabled = true;
      per_monitor_directories = true;
      directory = self + "/assets";
      default.path = self + "/assets/Landscape/frieren_sky_flowers.jpg";
      monitor.DP-2 = {
        enabled = true;
        directory = self + "/assets/Vertical";
      };
    };
    # Noctalia is not managed by systemd
    wayland.windowManager.hyprland.settings.on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd([[
                for i in $(seq 1 20); do
                  if noctalia msg status >/dev/null 2>&1; then
                    break
                  fi
                  sleep 0.125
                done
                noctalia msg wallpaper-set DP-2 ~/.config/nix/assets/Vertical/casual_shorts.jpg
                noctalia msg wallpaper-set DP-3 ~/.config/nix/assets/Landscape/frieren_sky_flowers.jpg
              ]])
            end
          '')
        ];
      }
    ];
  };
in
{
  flake.modules.homeManager.ellinia-wallpaper = homeManagerEllinia;
}
