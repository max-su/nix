{
  inputs,
  pkgs,
  ...
}:
let
  homeManager = { pkgs, ...} : {
    programs.firefox = {
      enable = true;

      nativeMessagingHosts = [
        inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}

