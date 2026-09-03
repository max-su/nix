# https://docs.noctalia.dev/noctalia/ v5
# To make Noctalia’s wifi, bluetooth, power-profile, and battery feature available, please ensure the following NixOS options are enabled:
#
#     networking.networkmanager.enable
#     hardware.bluetooth.enable
#     services.power-profiles-daemon.enable or services.tuned.enable
#     services.upower.enable

{ ... }:
let
  noctaliaRequirements = {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
  };
in
{
  flake.modules.nixos.base.imports = [ noctaliaRequirements ];
}
