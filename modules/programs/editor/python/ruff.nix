{ ... }:
let
  homeManager = {
    programs.ruff = {
      enable = true;
      settings = {
        lint.ignore = [ "F821" ];
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
