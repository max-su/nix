{ _ }:
let
  networking = {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
in
{
  flake.modules.nixos.base.imports = [ networking ];
}
