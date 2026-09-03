{ inputs, ... }:
{
  flake.modules.nixos.base = {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
    };
  };

  flake.modules.homeManager.nh = {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
    };
  };
}
