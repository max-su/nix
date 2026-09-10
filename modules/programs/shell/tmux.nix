{ ... }:
let
  homeManager = { lib, pkgs, ... }: {
    home.activation.installTPM = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
      fi
    '';

    programs.tmux = {
      enable = true;
      extraConfig = ''
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'TanglingTreats/tmux-everforest'
        set -g @plugin 'vaaleyard/tmux-dotbar'
        set -g @plugin 'sainnhe/tmux-fzf'
        set -g @plugin 'christoomey/vim-tmux-navigator'
        set -g @plugin 'tmux-plugins/tmux-resurrect'
        set -g @plugin 'tmux-plugins/tmux-continuum'
        set -g @continuum-restore 'on'
        set -g @resurrect-capture-pane-contents 'on'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-processes 'nvim'

        # Change prefix from Ctrl-b to Ctrl-a
        unbind C-b
        set -g prefix C-a
        bind C-a send-prefix

        # Default is find-window
        unbind f
        set-environment -g TMUX_FZF_LAUNCH_KEY "f"

        # Resize panes
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # Split panes with \ and -
        unbind '"'
        unbind %
        bind '\' split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"

        # vim-tmux-navigator
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Everforest Theming
        set -g @tmux-everforest 'dark-hard'

        # Dotbar Theming
        set -g @tmux-dotbar-bg "#272E33"
        set -g @tmux-dotbar-fg "#859289"
        set -g @tmux-dotbar-fg-current "#D3C6AA"
        set -g @tmux-dotbar-fg-session "#E67E80"
        set -g @tmux-dotbar-fg-prefix "#D699B6"

        set-option -g renumber-windows on
        set -g base-index 1
        set -g pane-base-index 1

        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        set -g @tmux-dotbar-ssh-icon '󰌘'
        set -g @tmux-dotbar-ssh-icon-only false
        set -g @tmux-dotbar-ssh-enabled true
        set -g @tmux-dotbar-session-position "right"
        set -g @tmux-dotbar-rounded true
        set -g @tmux-dotbar-session-text "#S 🌸 "
        set -g @tmux-dotbar-window-status-format " #I #W "

        run '~/.tmux/plugins/tpm/tpm'
      '';
    };
  };
in
{
  flake.modules.homeManager.frieren.imports = [ homeManager ];
}
