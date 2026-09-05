{ ... }:
let
  homeManager = {
    xdg.configFile."hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
        custom_picker_binary = hyprland-preview-share-picker
      }
    '';
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
