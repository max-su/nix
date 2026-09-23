{ ... }:
let
  homeManager = {
    programs.herdr = {
      enable = true;

      settings = {
        onboarding = false;

        keys = {
          prefix = "ctrl+a";

          command = [
            { key = "ctrl+h"; type = "plugin_action"; command = "herdr-splits.nav-left";  description = "navigate left (vim/herdr)"; }
            { key = "ctrl+j"; type = "plugin_action"; command = "herdr-splits.nav-down";  description = "navigate down (vim/herdr)"; }
            { key = "ctrl+k"; type = "plugin_action"; command = "herdr-splits.nav-up";    description = "navigate up (vim/herdr)"; }
            { key = "ctrl+l"; type = "plugin_action"; command = "herdr-splits.nav-right"; description = "navigate right (vim/herdr)"; }
            { key = "alt+h"; type = "plugin_action"; command = "herdr-splits.resize-left";  description = "resize left (herdr-splits)"; }
            { key = "alt+j"; type = "plugin_action"; command = "herdr-splits.resize-down";  description = "resize down (herdr-splits)"; }
            { key = "alt+k"; type = "plugin_action"; command = "herdr-splits.resize-up";    description = "resize up (herdr-splits)"; }
            { key = "alt+l"; type = "plugin_action"; command = "herdr-splits.resize-right"; description = "resize right (herdr-splits)"; }
          ];
        };

        theme = {
          name = "gruvbox";

          custom = {
            panel_bg      = "#272e33";
            sidebar_bg    = "#2e383c";
            surface_dim   = "#2e383c";
            surface0      = "#374145";
            surface1      = "#414b50";
            active_row_bg = "#374145";
            selection_bg  = "#414b50";

            text     = "#d3c6aa";
            subtext0 = "#9da9a0";
            overlay0 = "#7a8478";
            overlay1 = "#859289";

            accent = "#a7c080";
            green  = "#a7c080";
            teal   = "#83c092";
            blue   = "#7fbbb3";
            yellow = "#dbbc7f";
            red    = "#e67e80";
            peach  = "#e69875";
            mauve  = "#d699b6";
          };
        };

        ui.accent = "#a7c080";
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
