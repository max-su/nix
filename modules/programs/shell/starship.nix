{ ... }:
{
  flake.modules.nixos.base.imports = [
    { programs.starship.enable = true; }
  ];

  flake.modules.homeManager.frieren.imports = [
    ({ config, ... }: {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };
    })
  ];
}
