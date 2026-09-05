{ ... }:
let
  nixSettings = {
    nix.settings = {
      experimental-features = "nix-command flakes";
      substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixSettings ];
  flake.modules.darwin.base.imports = [
    { nix.settings.experimental-features = "nix-command flakes"; }
  ];
}
