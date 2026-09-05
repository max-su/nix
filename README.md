<h2 align="center">❄️ mix's Nix Config</h2>
<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="588" />
</p>
<p align="center">
  <img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=for-the-badge&logo=nixos&color=c4a7e7&logoColor=e0def4&labelColor=191724">
  <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fghloc.dev%2Fapi%2Fmax-su%2Fnix%2Fbadge%3Fbranch%3Dmain&style=for-the-badge&color=f6c177&labelColor=191724&logoColor=e0def4&logo=pipecat&label=Lines%20of%20Code">
  <img src="https://img.shields.io/badge/Pattern-Dendritic-informational.svg?style=for-the-badge&color=a6da95&labelColor=302D41&logo=mongodb&logoColor=D9E0EE">
</p>
<p align="center">
  My Nix flake that declaratively configures my desktop (ellinia) written with <a href="https://github.com/hercules-ci/flake-parts">flake-parts</a> and <a href="https://github.com/vic/import-tree">import-tree</a>.
</p>

## **ellinia** (NixOS): [Hyprland](https://hyprland.org) + [Noctalia](https://docs.noctalia.dev)
  [![Screenshot](assets/screenshots/rice.png)](assets/screenshots/rice.png)

## Requirements
  - [flake-parts](https://github.com/hercules-ci/flake-parts)
  - [import-tree](https://github.com/denful/import-tree)
  - sweat and human labor those <!--LOC-->2370<!--/LOC--> lines were fun to write
  - a lot of rose pine and my sorrow pining for a tiling window manager again b/c god forbid a person use a mouse
  - the willpower to write nix this language is oh so wonderful (it makes me miss haskell)

## Dendritic vs Standard (configuration.nix + home.nix)
These code stubs aim to elucidate how to decompose a monolithic `configuration.nix` + `home.nix` into modules following the dendritic pattern.

[flake.nix](https://github.com/max-su/nix/blob/main/flake.nix) is the entry for the package, and [modules/hosts/ellinia/configuration.nix](https://github.com/max-su/nix/blob/e358231c335f1d1856a446d73e760094c54fae80/modules/hosts/ellinia/configuration.nix#L37) defines the magical `inputs.nixpkgs.lib.nixosSystem` that makes **ellinia** exist in more than my imagination

> *"Magic is a world of visual imagination. Can you imagine defeating a mage who controls water in the rain? At the very least, I can't."*
>
> ~ **Frieren**

```nix
# Dendritic Pattern module
# ./modules/desktop/hyprland/hyprland.nix
{
  inputs,
  ...
}:
let
  # This can either be a function like it is currently or an attribute set
  nixos = { pkgs, ... } : {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage= inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
  # 
  nixosAttrSet = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
  homeManager = { lib, ... } : {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      # https://discourse.nixos.org/t/nixos-ozone-wl-1-seemingly-not-having-any-affect/56776/2
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      configType = "lua";

      settings = {
        config = {
          general = {
            gaps_out = 8;
          };
          decoration = {
            rounding = 10;
            active_opacity = 0.8;
            inactive_opacity = 0.75;
          };
        };
        bind = [
          {
            _args = [
              "ALT + SHIFT + F12"
              (lib.generators.mkLuaInline ''
                hl.dsp.exec_cmd("hyprctl activewindow > /tmp/activewindow.txt")
              '')
            ];
          }
        ];
      };
    };
  };
in
{
  # It looks like assignment but it is .append() for those familiar with python
  # flake.modules.nixos.base.imports.append(nixos);

  # Add the function to the new module that's equivalent to "configuration.nix"
  flake.modules.nixos.base.imports = [ nixos ];
  # Add the function to the new module that's equivalent to "home.nix"
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
```

```nix
# configuration.nix
{ inputs, config, pkgs, ... }:

{
  # flake.modules.nixos.base.imports = [ nixos ];
  # flake.modules.nixos.base.imports
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.noctalia-greeter.nixosModules.default
    ];
  # --------------------------------------------
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage= inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
  # --------------------------------------------
  system.stateVersion = "26.05"; # Did you read the comment?
  home-manager.backupFileExtension = "backup";
}
```

```nix
# home.nix
{ config, pkgs, inputs, lib,  ... }:
{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "frieren";
    homeDirectory = "/home/frieren";
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "26.05";
  };
  # flake.modules.homeManager.frieren.imports = [ homeManager ];
  # flake.modules.homeManager.frieren.imports
  imports = [ 
    inputs.lazyvim.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    inputs.vicinae.homeManagerModules.default
  ];
  # --------------------------------------------
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    configType = "lua";

    settings = {
      config = {
        general = {
          gaps_out = 8;
        };
        decoration = {
          rounding = 10;
          active_opacity = 0.8;
          inactive_opacity = 0.75;
        };
      };
      bind = [
        {
          _args = [
            "ALT + SHIFT + F12"
            (lib.generators.mkLuaInline ''
              hl.dsp.exec_cmd("hyprctl activewindow > /tmp/activewindow.txt")
            '')
          ];
        }
      ];
    };
  };
  # --------------------------------------------
}
```

### Links for the poor souls w/ brain worms that want to try their hand at NixOS
- [Noogle](https://noogle.dev/) - Nix function search
- [Home Manager Configuration](https://mynixos.com/home-manager/options) - home-manager module options/schema
