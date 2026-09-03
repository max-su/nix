{ ... }:
{
  flake.modules.nixos.base.imports = [
    ({ pkgs, ... }: {
      users.users.frieren = {
        isNormalUser = true;
        shell = pkgs.zsh;
        # Having a user be in the "input" group has implications on security
        # Used for via +
        # https://github.com/savedra1/clipse#auto-paste
        extraGroups = [ "wheel" "networkmanager" "input" ];
        packages = with pkgs; [ ];
      };
    })
  ];
}
