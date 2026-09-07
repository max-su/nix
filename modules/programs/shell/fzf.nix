{ ... }:
let
  homeManager = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;

      # Ctrl+T — file/directory picker
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
      fileWidgetOptions = [
        "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      ];

      # Alt+C — directory jump
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
      changeDirWidgetOptions = [
        "--preview 'eza --tree --color=always {} | head -200'"
      ];

      # Ctrl+R — history search
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];

      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--color=bg+:#26233a,bg:#191724,spinner:#f6c177,hl:#ebbcba"
        "--color=fg:#e0def4,header:#ebbcba,info:#9ccfd8,pointer:#c4a7e7"
        "--color=marker:#eb6f92,fg+:#e0def4,prompt:#9ccfd8,hl+:#ebbcba"
      ];
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
