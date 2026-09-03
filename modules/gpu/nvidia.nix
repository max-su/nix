# Requires
# nixpkgs.config.allowUnfree = true;
# to be set
{ ... }:
{
  flake.modules.nixos.nvidia = {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
    # MSI Afterburner
    services.lact.enable = true;
  };
}
