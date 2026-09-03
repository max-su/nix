{ self,
  inputs,
  ...
}:
let
  fontsModule = { config, pkgs, ... }: {
    nixpkgs.overlays = [ self.overlays.fonts ];
    fonts.packages = [ pkgs.codelia-nerd-font ];
    fonts.fontconfig.enable = true;
  };
in
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

  flake.modules.nixos.base.imports = [ fontsModule ];
}
