{ ... }:
let
  nixos = {
    # github.com/savedra1/clipse
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="777", GROUP="input", OPTIONS+="static_node=uinput"
    '';
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
}
