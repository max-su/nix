{ ... }:
let
  keyboard = {
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
in
{
  flake.modules.nixos.base.imports = [ keyboard ];
}
