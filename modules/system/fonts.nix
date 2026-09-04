{
  inputs,
  ...
}:
let
  codeliaFont = pkgs: pkgs.stdenvNoCC.mkDerivation {
    pname = "codelia-nerd-font";
    version = "1.0";
    src = inputs.codelia;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp $src/CodeliaNerdFont-Regular.otf $out/share/fonts/opentype/
    '';
  };

  fontsModule = { pkgs, ... }: {
    fonts.packages = [ (codeliaFont pkgs) ];
    fonts.fontconfig.enable = true;
  };
in
{
  flake.modules.nixos.base.imports = [ fontsModule ];
}
