{ ... }:
let
  homeManager = {
    programs.kitty = {
      enable = true;
      themeFile = "rose-pine";
      font = {
        name = "Codelia Nerd Font";
        size = 13;
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
