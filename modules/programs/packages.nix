{ inputs, ... }:
let
  packages = { pkgs, ... }: {
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
      spotify

      (yazi.override {
        _7zz = _7zz-rar;
      })

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
    ];
  };
in
{
  flake.modules.nixos.base.imports = [
    packages
  ];
}
