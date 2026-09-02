# modules/fonts.nix
{ self, inputs, ... }:
{
  flake.overlays.fonts = final: prev: {
    codelia-nerd-font = final.stdenvNoCC.mkDerivation {
      pname = "codelia-nerd-font";
      version = "1.0";
      src = inputs.codelia;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp $src/CodeliaNerdFont-Regular.otf $out/share/fonts/opentype/
      '';
    };
  };
}
