{ inputs, ... }:
let
  nixos = {
    nixpkgs.overlays = [
      helium-flake.overlays.default
    ];
  };
  homeManager = { pkgs, ... }: {
    imports = [
      inputs.helium-flake.nixosModules.default
    ];

    programs.helium = {
      enable = true;

      # Optional: override the package
      # package = pkgs.helium;

      # 🚩 Flags - Command-line arguments always passed to Helium
      flags = [
        "--ozone-platform-hint=auto"
      ];

      # 🎯 Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
      # Also written to /etc/helium/policies/managed/ for future compatibility
      # policies = {
      #   "BrowserSignin" = 0;
      #   "PasswordManagerEnabled" = false;
      #   "SyncDisabled" = true;
      #   "SpellcheckEnabled" = true;
      #   "SpellcheckLanguage" = [ "en-US" ];
      # };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
