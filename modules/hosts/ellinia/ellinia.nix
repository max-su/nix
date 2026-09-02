{ inputs, self, ... }:
{
  flake.modules.nixos.ellinia = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
      self.modules.nixos.nh
    ];

    networking.hostName = "ellinia";
    system.stateVersion = "26.05";

    programs.nh.flake = "/home/frieren/.config/nix-dendritic";
  };

  flake.nixosConfigurations.ellinia = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs self; };
    modules = [
      self.modules.nixos.ellinia
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
            home.username = "frieren";
            home.homeDirectory = "/home/frieren";
            home.stateVersion = "26.05";
            # TODO: Change this to nix
            programs.nh.flake = "/home/frieren/.config/nix-dendritic";
          };
        };
      }
    ];
  };
}
