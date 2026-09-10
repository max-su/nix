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
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # https://discourse.nixos.org/t/nixos-ozone-wl-1-seemingly-not-having-any-affect/56776/2
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      configType = "lua";

      extraConfig = ''
        hl.config ({ misc = { allow_session_lock_restore = 1 }})
        hl.config({
          xwayland = {
            force_zero_scaling = true,
            use_nearest_neighbor = true,
          }
        })

        -- Animation speed multiplier
        -- 1.0 = default
        -- 2.0 = twice as fast
        -- 0.5 = half as fast
        local pseed = 1.5

        local speed = function(value)
          return value * pseed
        end

        hl.config({
          misc = {
            allow_session_lock_restore = 1
          }
        })

        hl.config({
          xwayland = {
            force_zero_scaling = true,
            use_nearest_neighbor = true,
          }
        })

        hl.curve("linear", {
          type = "bezier",
          points = {{0, 0}, {1, 1}}
        })

        hl.curve("md3_standard", {
          type = "bezier",
          points = {{0.2, 0}, {0, 1}}
        })

        hl.curve("md3_decel", {
          type = "bezier",
          points = {{0.05, 0.7}, {0.1, 1}}
        })

        hl.curve("md3_accel", {
          type = "bezier",
          points = {{0.3, 0}, {0.8, 0.15}}
        })

        hl.curve("overshot", {
          type = "bezier",
          points = {{0.05, 0.9}, {0.1, 1.1}}
        })

        hl.curve("crazyshot", {
          type = "bezier",
          points = {{0.1, 1.5}, {0.76, 0.92}}
        })

        hl.curve("hyprnostretch", {
          type = "bezier",
          points = {{0.05, 0.9}, {0.1, 1.0}}
        })

        hl.curve("menu_decel", {
          type = "bezier",
          points = {{0.1, 1}, {0, 1}}
        })

        hl.curve("menu_accel", {
          type = "bezier",
          points = {{0.38, 0.04}, {1, 0.07}}
        })

        hl.curve("easeInOutCirc", {
          type = "bezier",
          points = {{0.85, 0}, {0.15, 1}}
        })

        hl.curve("easeOutCirc", {
          type = "bezier",
          points = {{0, 0.55}, {0.45, 1}}
        })

        hl.curve("easeOutExpo", {
          type = "bezier",
          points = {{0.16, 1}, {0.3, 1}}
        })

        hl.curve("softAcDecel", {
          type = "bezier",
          points = {{0.26, 0.26}, {0.15, 1}}
        })

        hl.curve("md2", {
          type = "bezier",
          points = {{0.4, 0}, {0.2, 1}}
        })

        hl.animation({
          leaf = "windows",
          enabled = true,
          speed = speed(3),
          bezier = "md3_decel",
          style = "popin 60%"
        })

        hl.animation({
          leaf = "windowsIn",
          enabled = true,
          speed = speed(3),
          bezier = "md3_decel",
          style = "popin 60%"
        })

        hl.animation({
          leaf = "windowsOut",
          enabled = true,
          speed = speed(3),
          bezier = "md3_accel",
          style = "popin 60%"
        })

        hl.animation({
          leaf = "border",
          enabled = true,
          speed = speed(10),
          bezier = "default"
        })

        hl.animation({
          leaf = "fade",
          enabled = true,
          speed = speed(3),
          bezier = "md3_decel"
        })

        hl.animation({
          leaf = "layersIn",
          enabled = true,
          speed = speed(3),
          bezier = "menu_decel",
          style = "slide"
        })

        hl.animation({
          leaf = "layersOut",
          enabled = true,
          speed = speed(1.6),
          bezier = "menu_accel"
        })

        hl.animation({
          leaf = "fadeLayersIn",
          enabled = true,
          speed = speed(2),
          bezier = "menu_decel"
        })

        hl.animation({
          leaf = "fadeLayersOut",
          enabled = true,
          speed = speed(4.5),
          bezier = "menu_accel"
        })

        hl.animation({
          leaf = "workspaces",
          enabled = true,
          speed = speed(7),
          bezier = "menu_decel",
          style = "slide"
        })

        hl.animation({
          leaf = "specialWorkspace",
          enabled = true,
          speed = speed(3),
          bezier = "md3_decel",
          style = "slidevert"
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
              class = "zen";
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
            _args = [
              "ALT + SHIFT + H"
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "l" })'')
            ];
          }
          {
            _args = [
              "ALT + SHIFT + J"
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "d" })'')
            ];
          }
          {
            _args = [
              "ALT + SHIFT + K"
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "u" })'')
            ];
          }
          {
            _args = [
              "ALT + SHIFT + L"
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "r" })'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + H"
              (lib.generators.mkLuaInline ''hl.dsp.layout("splitratio -0.1")'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + L"
              (lib.generators.mkLuaInline ''hl.dsp.layout("splitratio +0.1")'')
            ];
          }
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
              "ALT + SHIFT + Q"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("firefox-devedition")'')
            ];
          }
          {
            _args =[
              "ALT + Q"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("zen")'')
            ];
          }
          {
            _args =[
              "ALT + D"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg media next")'')
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
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy")'')
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
