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
        set -g @plugin 'rose-pine/tmux'
        set -g @plugin 'vaaleyard/tmux-dotbar'
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

        # Rose Pine Theming
        set -g @rose_pine_variant 'main'
        set -g @rose_pine_host 'on'
        set -g @rose_pine_hostname_short 'on'
        set -g @rose_pine_date_time '%R'
        set -g @rose_pine_user 'on'
        set -g @rose_pine_directory 'on'
        set -g @rose_pine_bar_bg_disable 'on'
        set -g @rose_pine_only_windows 'on'
        set -g @rose_pine_bar_bg_disabled_color_option 'default'
        set -g @rose_pine_window_status_separator "  "
        set -g @rose_pine_disable_active_window_menu 'on'
        set -g @rose_pine_default_window_behavior 'on'
        set -g @rose_pine_show_current_program 'on'
        set -g @rose_pine_show_pane_directory 'on'
        set -g @rose_pine_left_separator ' > '
        set -g @rose_pine_right_separator ' < '
        set -g @rose_pine_field_separator '  '
        set -g @rose_pine_window_separator ' - '
        set -g @rose_pine_session_icon '''
        set -g @rose_pine_current_window_icon '''
        set -g @rose_pine_folder_icon '''
        set -g @rose_pine_username_icon '''
        set -g @rose_pine_hostname_icon '󰒋'
        set -g @rose_pine_date_time_icon '󰃰'
        set -g @rose_pine_prioritize_windows 'on'
        set -g @rose_pine_width_to_hide '80'
        set -g @rose_pine_window_count '5'

        # Dotbar Theming
        set -g @tmux-dotbar-bg "#191724"
        set -g @tmux-dotbar-fg "#6e6a86"
        set -g @tmux-dotbar-fg-current "#e0def4"
        set -g @tmux-dotbar-fg-session "#C86F87"
        set -g @tmux-dotbar-fg-prefix "#c4a7e7"

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
