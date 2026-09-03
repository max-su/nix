{
  inputs = {
    nh.url = "github:nix-community/nh";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # MacOS
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Linux specific
    hyprland.url = "github:hyprwm/Hyprland";
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    noctalia-greeter.inputs.nixpkgs.follows = "nixpkgs";
    hyprland-preview-share-picker = {
      url = "git+https://github.com/WhySoBad/hyprland-preview-share-picker?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # General
    lazyvim.url = "github:pfassina/lazyvim-nix";
    vicinae.url = "github:vicinaehq/vicinae";
    # Has MacOS support as well https://gerg-l.github.io/spicetify-nix/usage.html
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    # Licensed font, fetch as a source tree, disable feature on first nixos-build as
    # ssh key has yet to be added to github account
    codelia = {
      url = "git+ssh://git@github.com/max-su/codelia.git";
      flake = false;
    };
  };

  outputs = inputs:
    # In your flake.nix - import every .nix file under ./modules
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./modules);
}
