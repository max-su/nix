{ ... }:
{
  flake.modules.homeManager.frieren = { lib, ... }: {
    home = {
      username = "frieren";
      homeDirectory = "/home/frieren";
      stateVersion = "26.05";
      activation.createSaccharineDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/Code/saccharine"
      '';
      activation.createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/Pictures/screenshots"
      '';
    };

    programs.home-manager.enable = true;
  };
}
