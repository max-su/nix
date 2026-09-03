{
  pkgs,
  ...
}:
let
  greetd = {
    pkgs,
    ...
  }:
  {
    services.greetd = {
      enable = true;

      settings = {
        default_session = {
          command = "${pkgs.noctalia-greeter}/bin/noctalia-greeter";
        };

        initial_session = {
          command = "uwsm start -eD Hyprland start-hyprland";
          user = "frieren";
        };
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [
    greetd
  ];
}
