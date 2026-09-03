{ 
  inputs,
  pkgs,
  ...
}:
{
  flake.modules.homeManager.yazi = {
    nixpkgs.overlays = [
      inputs.nix-yazi-flavors.overlays.default
    ];

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
