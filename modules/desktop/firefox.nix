{
  inputs,
  pkgs,
  ...
}:
let
  homeManager = { pkgs, ...} : {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition;

      nativeMessagingHosts = [
        inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}

