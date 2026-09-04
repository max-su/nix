{
  config,
  ...
}:
{
  flake.modules.homeManager.frieren = {
    # TODO: auto discovery through imports.
    # manual
    # imports = [
    #   config.flake.modules.homeManager.yazi
    #   config.flake.modules.homeManager.zsh
    # ];

    home = {
      username = "frieren";
      homeDirectory = "/home/frieren";
      stateVersion = "26.05";
    };
  };
}
