{ ... }:
{
  flake.modules.nixos.base.imports = [ { nixpkgs.config.allowUnfree = true; } ];
  flake.modules.darwin.base.imports = [ { nixpkgs.config.allowUnfree = true; } ];
}
