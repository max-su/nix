{ ... }:
let
  nixos = { programs.starship.enable = true; };
  home = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ home ];
}
