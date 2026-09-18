{ ... }:
let
  homeManager = {
    pkgs,
    ...
  }:
  {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ "zen.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/about" = [ "zen.desktop" ];
        "x-scheme-handler/unknown" = [ "zen.desktop" ];
        "inode/directory" = [ "yazi.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      };
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
