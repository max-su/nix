{
  inputs,
  ...
}:
let
  nixos = { pkgs, ... } : {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage= inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
  homeManager = { lib, ... } : {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      configType = "lua";

      extraConfig = ''
      hl.config({
        xwayland = {
          force_zero_scaling = true,
          use_nearest_neighbor = true,
        }
      })
      '';

      settings = {
        config = {
          general = {
            gaps_out = 8;
          };
          decoration = {
            rounding = 10;
            active_opacity = 0.8;
            inactive_opacity = 0.75;
          };
        };
        on = [
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("clipse -listen")
                end
              '')
            ];
          }
          # https://codeberg.org/LGFae/awww
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("awww-daemon")
                end
              '')
            ];
          }
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("noctalia")
                  hl.exec_cmd("noctalia msg wallpaper-set DP-2 ~/.config/nix/assets/Vertical/casual_shorts.jpg");
                  hl.exec_cmd("noctalia msg wallpaper-set DP-3 ~/.config/nix/assets/Landscape/frieren_sky_flowers.jpg");
                end
              '')
            ];
          }
          {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
                end
              '')
            ];
          }
        ];
        window_rule = [
          {
            match = {
              class = "firefox";
            };
            suppress_event = "maximize";
          }
          {
            match = {
              class = "vesktop";
            };
            suppress_event = "maximize";
          }
          {
            match = {
              class = "spotify";
            };
            suppress_event = "maximize";
          }
        ];
        bind = [
          {
            _args =[
              "ALT + 1"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")
            ];
          }
          {
            _args =[
              "ALT + 2"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")
            ];
          }
          {
            _args =[
              "ALT + 3"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")
            ];
          }
          {
            _args =[
              "ALT + 4"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")
            ];
          }
          {
            _args =[
              "ALT + 5"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")
            ];
          }
          {
            _args =[
              "ALT + 6"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")
            ];
          }
          {
            _args =[
              "ALT + 7"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")
            ];
          }
          {
            _args =[
              "ALT + 8"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")
            ];
          }
          {
            _args =[
              "ALT + 9"
              (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 1"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 2"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 3"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 4"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 5"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 6"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 7"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 8"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + 9"
              (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
            ];
          }
          {
            _args =[
              "ALT + W"
              (lib.generators.mkLuaInline "hl.dsp.window.close()")
            ];
          }
          {
            _args =[
              "ALT + F"
              (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })'')
            ];
          }
          {
            _args =[
              "ALT + Q"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("firefox")'')
            ];
          }
          {
            _args =[
              "ALT + E"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty -e yazi")'')
            ];
          }
          {
            _args =[
              "ALT + Return"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty")'')
            ];
          }
          {
            _args = [
              "CTRL + SPACE"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("vicinae toggle")'')
            ];
          }
          {
            _args = [
              "ALT + SHIFT + S"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg screenshot-region")'')
            ];
          }
          {
            _args = [
              "ALT + SHIFT + A"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen")'')
            ];
          }
          {
            _args = [
              "ALT + F12"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("lact gui")'')
            ];
          }
          {
            _args =[
              "ALT + SHIFT + F11"
              (lib.generators.mkLuaInline "hl.dsp.exit()")
            ];
          }
          {
            _args = [
              "ALT + SHIFT + F12"
              (lib.generators.mkLuaInline ''
                hl.dsp.exec_cmd("hyprctl activewindow > /tmp/activewindow.txt")
              '')
            ];
          }
        ];
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
