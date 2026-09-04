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
  };
}
