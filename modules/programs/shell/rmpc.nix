{
  ...
}:
let homeManager = {
  config,
  ...
}:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
  };

  programs.rmpc = {
    enable = true;

    config = ''
      (
        address: "127.0.0.1:6600",
      )
    '';
  };
};
in
{
  flake.modules.homeManager.rmpc = homeManager;
}
