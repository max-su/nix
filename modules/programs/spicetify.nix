{ inputs, ... }:
let
  homeManager = { pkgs, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        # XWayland
        enable = false;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
        ];
        theme = spicePkgs.themes.ziro;
        colorScheme = "rose-pine";
      };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
