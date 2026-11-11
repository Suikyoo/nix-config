{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    # Basics
    mouse = true;              # click panes, drag borders, scroll
    keyMode = "vi";            # vi keys in copy mode
    baseIndex = 1;             # windows/panes start at 1 (easier to reach on the keyboard)
    historyLimit = 50000;
    escapeTime = 0;            # no delay after Esc (important for vim/neovim)
    clock24 = true;
    focusEvents = true;
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible                 # sane defaults
      yank                     # copy to system clipboard
      {
        plugin = resurrect;    # save/restore sessions: prefix C-s / prefix C-r
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;    # auto-save every 15 min, auto-restore on start
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];

    extraConfig = ''
      # True color in modern terminals
      set -as terminal-features ",xterm-256color:RGB"

      # Intuitive splits that keep the current directory
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Move between panes with vim keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes with prefix + Shift-hjkl (repeatable)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Renumber windows when one closes
      set -g renumber-windows on

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded"

      # Simple status bar
      set -g status-style "bg=default,fg=white"
      set -g status-left "#[bold] #S "
      set -g status-right "%H:%M  %d %b "
      set -g window-status-current-style "fg=cyan,bold"
    '';
  };
}

