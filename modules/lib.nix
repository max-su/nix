# modules/lib.nix
{ ... }:
{
  # Some programs will use an outdated version of Electron and launch in XWayland
  flake.lib.forceWayland = pkgs: pkg: binName:
    pkgs.symlinkJoin {
      name = "${pkg.pname or pkg.name}-wayland";
      paths = [ pkg ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${binName} \
          --add-flags "--ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations"
      '';
    };
}
