{ ... }:
let
  nixos = {
    programs.zsh.enable = true;
  };
  homeManager = { config, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gp = "git push";
        pbcopy = "wl-copy";
        lc = "mv ~/Downloads/lc.pdf";
      };
      initContent = ''
        eval "$(jump shell)"
      '';
      history = {
        size = 10000;
        path = "${config.home.homeDirectory}/.zsh_history";
        ignoreAllDups = true;
      };
    };
  };
in
{
  flake.modules.nixos.base.imports = [ nixos ];
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
