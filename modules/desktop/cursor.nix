
{ inputs, ... }:
let
  homeManager = {
    pkgs,
    ...
  }:
  {
    home.pointerCursor = {
      enable = true;
      package = pkgs.maplestory-cursor;
      name = "Maple";
      size = 56;

      gtk.enable = true;
      x11.enable = true;

      hyprcursor = {
        enable = true;
        size = 56;
      };
    };
    # Guarantees UWSM env's are set before hyprland is launched
    xdg.configFile."uwsm/env".text = ''
      export XCURSOR_THEME=Maple
      export XCURSOR_SIZE=56
    '';

  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
