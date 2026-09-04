{ ... }:
{
  flake.modules.nixos.gaming = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };
}
