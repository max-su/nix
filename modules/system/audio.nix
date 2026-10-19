{ ... }:
let
  audio = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."92-sample-rates" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
        };
      };
    };
    security.rtkit.enable = true;
  };
in
{
  flake.modules.nixos.base.imports = [ audio ];
}
