{ 
  inputs,
  pkgs,
  ...
}:
{
  flake.modules.nixos.base.imports = [
    {
      nixpkgs.overlays = [
        inputs.nix-yazi-flavors.overlays.default
      ];
    }
  ];

  flake.modules.homeManager.yazi = {
    home.packages = [
      pkgs.yazi
    ];

    programs.yazi = {
      enable = true;
      flavors = pkgs.yaziFlavors;

      theme.flavor = {
        dark = "kanagawa";
        light = "catppuccin-latte";
      };
    };
  };
}
