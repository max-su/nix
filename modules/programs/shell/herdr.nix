{ ... }:
let
  homeManager = {
    programs.herdr = {
      enable = true;

      settings = {
        keys.prefix = "ctrl+a";

        theme = {
          name = "gruvbox"; # closest built-in fallback for any token not overridden below

          custom = {
            # backgrounds
            panel_bg      = "#272e33"; # bg0 hard
            sidebar_bg    = "#2e383c"; # bg1
            surface_dim   = "#2e383c"; # bg1
            surface0      = "#374145"; # bg2
            surface1      = "#414b50"; # bg3
            active_row_bg = "#374145"; # bg2
            selection_bg  = "#414b50"; # bg3

            # foreground
            text     = "#d3c6aa"; # fg
            subtext0 = "#9da9a0"; # grey2
            overlay0 = "#7a8478"; # grey0
            overlay1 = "#859289"; # grey1

            # accent + syntax tokens
            accent = "#a7c080"; # green
            green  = "#a7c080";
            teal   = "#83c092"; # aqua
            blue   = "#7fbbb3";
            yellow = "#dbbc7f";
            red    = "#e67e80";
            peach  = "#e69875"; # orange
            mauve  = "#d699b6"; # purple
          };
        };

        ui.accent = "#a7c080"; # green, matched to accent above
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
