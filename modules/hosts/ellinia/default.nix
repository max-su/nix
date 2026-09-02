{ inputs, self, ... }:
{
  flake.modules.nixos.ellinia = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
    ];

    networking.hostName = "ellinia";
    system.stateVersion = "26.05";

    # Bootloader
    boot.loader.systemd-boot.enable = false;
    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    programs.zsh.enable = true;

    users.users.frieren = {
      isNormalUser = true;
      home = "/home/frieren";
      shell = pkgs.zsh; # Setting Zsh as the default shell
      # https://github.com/savedra1/clipse#Auto-paste input
      extraGroups = [ "wheel" "networkmanager" "input" ];
    };

    programs.nh.flake = "/home/frieren/.config/nix";
  };

  flake.nixosConfigurations.ellinia = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs self; };
    modules = [
      self.modules.nixos.ellinia
      self.modules.nixos.nh
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs self; };
          users.frieren = {
            imports = [
              self.modules.homeManager.nh
              self.modules.homeManager.git
              self.modules.homeManager.zsh
            ];
            home = {
              username = "frieren";
              homeDirectory = "/home/frieren";
              stateVersion = "26.05";
            };
          };
        };
      }
    ];
  };
}
