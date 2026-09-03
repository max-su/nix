# Configuration file for my 2025 machine, B650E PG-ITX WiFi, 9800X3D + 5070TI
{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos."hosts/ellinia" = {pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
      config.flake.modules.nixos.base
    ];

    networking.hostName = "ellinia";
    # This records the on-disk schema from the original installation. Do not
    # bump it when updating nixpkgs; only change it for a deliberate reinstall.
    system.stateVersion = "26.05";

    # Bootloader + Kernel
    boot = {
      loader = {
        systemd-boot.enable = false;
        limine.enable = true;
        efi.canTouchEfiVariables = false;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };

    nixpkgs.overlays = [ config.flake.overlays.fonts ];
    fonts.packages = [ pkgs.codelia-nerd-font ];
    fonts.fontconfig.enable = true;
  };

  flake.nixosConfigurations.ellinia = inputs.nixpkgs.lib.nixosSystem {
    modules = [ config.flake.modules.nixos."hosts/ellinia" ];
  };
}
