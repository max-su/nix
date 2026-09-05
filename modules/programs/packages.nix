{ inputs, self, ... }:
let
  # System Wide Installed Packages
  system = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      git
      kitty
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      firefox
      ripgrep
      fd
      btop
      fastfetch
      wl-clipboard
      clipse
      vesktop
      (yazi.override { _7zz = _7zz-rar; })
      poppler-utils
      ffmpegthumbnailer
      statix
      inputs.hyprland-preview-share-picker.packages.${pkgs.stdenv.hostPlatform.system}.default
      ffmpeg
      mpv
      rose-pine-cursor
      jump
      tmux
      tmuxp
      hydralauncher
      scanmem
      stremio-linux-shell
      obs-studio
      erdtree
      papirus-icon-theme
      maplestory-cursor
      pyright
    ];
  };

  # user/frieren's Packages
  home = { config, pkgs, ... }: {
    home.packages = [
      (self.lib.forceWayland pkgs config.programs.spicetify.spicedSpotify "spotify")
    ];
  };
in
{
  flake.modules.nixos.base.imports = [ system ];
  flake.modules.homeManager.frieren.imports = [ home ];
}
