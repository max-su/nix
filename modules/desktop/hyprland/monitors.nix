{ ... }:
{
  flake.modules.homeManager.ellinia-monitors = { ... }: {
    wayland.windowManager.hyprland.settings.monitor = [
      {
        output = "DP-2";
        mode = "2560x1440@144";
        position = "0x0";
        scale = 1;
        transform = 1;
      }
      {
        output = "DP-3";
        mode = "3840x2160@240";
        position = "1440x0";
        scale = 1.5;
      }
    ];
  };
}
