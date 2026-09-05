{ ... }:
let
  homeManager = {
    pkgs,
    ...
  }:
  {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
