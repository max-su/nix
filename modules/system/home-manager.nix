{
  config,
  ...
}:
{
  flake.modules.homeManager.frieren = {
    imports = [
      config.flake.modules.homeManager.frieren        # auto-composed: zsh, yazi, starship, nh, etc.
      config.flake.modules.homeManager.ellinia-monitors  # explicit: ellinia-only
    ];
    home = {
      username = "frieren";
      homeDirectory = "/home/frieren";
      stateVersion = "26.05";
    };
  };
}
