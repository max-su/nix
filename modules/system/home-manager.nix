{
  config,
  ...
}:
{
  flake.modules.homeManager.frieren = {
    home = {
      username = "frieren";
      homeDirectory = "/home/frieren";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
