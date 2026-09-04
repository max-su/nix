{ inputs, ... }:
let
  nixos = {
    nixpkgs.overlays = [
      inputs.nix-yazi-flavors.overlays.default
    ];
  };
  homeManager = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      flavors = pkgs.yaziFlavors;
      theme.flavor = {
        dark = "kanagawa";
        light = "catppuccin-latte";
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
