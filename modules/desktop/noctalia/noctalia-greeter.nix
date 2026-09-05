{
  inputs,
  ...
}:
let
  nixos = { pkgs, ... }: {
    imports = [ inputs.noctalia-greeter.nixosModules.default ];
    # TODO: change cursor later, validate if work on resumption from suspension, theme
    programs.noctalia-greeter = {
      enable = true;
      # Optional configuration
      greeter-args = "";
      # Full declarative greeter.toml (overwritten on each activation).
      # See examples/greeter.toml for every key (appearance.palette, output, …).
      settings = {
        cursor = {
          theme = "BreezeX-RosePine-Linux";
          size = 24;
          path = "${pkgs.rose-pine-cursor}/share/icons";
        };
        keyboard = {
          layout = "us";
        };
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
}
