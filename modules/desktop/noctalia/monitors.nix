{ self, ... }:
let
  homeManagerEllinia = {
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
  };
in
{
  flake.modules.homeManager.ellinia-wallpaper = homeManagerEllinia;
}
