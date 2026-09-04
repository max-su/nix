{ ... }:
let
  nixos = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };

  homeManager = {
    programs.mangohud = {
      enable = true;
      settings = {
        vram = true;
        fps = true;
        frametime = true;
        no_display = false;
        gpu_list = "0";
      };
    };
  };
in
{
  flake.modules.nixos.gaming = nixos;
  flake.modules.homeManager.gaming = homeManager;
}
