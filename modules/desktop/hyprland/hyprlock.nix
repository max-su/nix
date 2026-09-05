{
  inputs,
  ...
}:
let
  wallpaper = "${inputs.self}/assets/Landscape/frieren_sky_flowers.jpg";

  homeManager = {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = false;
          hide_cursor = true;
          grace = 2;
          no_fade_in = false;
        };
        background = [
          {
            monitor = "";
            path = wallpaper;
            blur_passes = 2;
            blur_size = 7;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.65;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];
        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
            color = "rgb(224, 222, 244)"; # text
            font_size = 90;
            font_family = "Codelia Nerd Font";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
            color = "rgb(144, 140, 170)"; # subtle
            font_size = 22;
            font_family = "Codelia Nerd Font";
            position = "0, 120";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "  $USER";
            color = "rgb(235, 188, 186)"; # rose
            font_size = 20;
            font_family = "Codelia Nerd Font";
            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];
        input-field = [
          {
            monitor = "";
            size = "300, 55";
            outline_thickness = 3;
            dots_size = 0.26;
            dots_spacing = 0.3;
            dots_center = true;
            outer_color = "rgb(196, 167, 231)"; # iris
            inner_color = "rgb(31, 29, 46)"; # surface
            font_color = "rgb(224, 222, 244)"; # text
            fade_on_empty = false;
            placeholder_text = ''<span foreground="##908caa">Password...</span>'';
            hide_input = false;
            check_color = "rgb(156, 207, 216)"; # foam
            fail_color = "rgb(235, 111, 146)"; # love
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            capslock_color = "rgb(246, 193, 119)"; # gold
            position = "0, -80";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
in
{
  flake.modules.homeManager.hyprlock = homeManager;
}
