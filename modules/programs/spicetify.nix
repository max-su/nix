{
  inputs,
  self,
  ...
}:
let
  home = {
    config,
    pkgs,
    ...
  }:
  {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
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

    xdg.desktopEntries.spotify = {
      name = "Spotify";
      exec = "${self.lib.forceWayland pkgs config.programs.spicetify.spicedSpotify "spotify"}/bin/spotify %U";
      icon = "spotify-client";
      type = "Application";
      categories = [ "Audio" "Music" "Player" "AudioVideo" ];
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ home ];
}
