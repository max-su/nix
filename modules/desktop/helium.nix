{ inputs, ... }:
let
  nixos = { pkgs, ... }: {
    nixpkgs.overlays = [
      inputs.helium-flake.overlays.default
    ];

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
}
