{ ... }:
let
  homeManager = {
    programs.kitty = {
      enable = true;
      themeFile = "everforest_dark_hard";
      font = {
        name = "Codelia Nerd Font";
        size = 14;
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
