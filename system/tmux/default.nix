{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = false;
    escapeTime = 10;
    historyLimit = 10000;
    terminal = "tmux-256color";
    newSession = true;
    extraConfig = ''
      set -ga terminal-overrides 'foot:Tc'
      set -g set-titles on
      setw -g pane-base-index 1
      set -g mouse on
      set-option -sa terminal-features \',xterm-kitty:RGB\'
      new -d -s $USER
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
      set -g base-index 1
      setw -g pane-base-index 1
      set-option -g renumber-windows on
      set -g prefix C-w
      unbind C-b
      bind C-a send-prefix
      bind F1 selectw -t:10
      bind F2 selectw -t:11
      bind F3 selectw -t:12
      bind F4 selectw -t:13
      bind F5 selectw -t:14
      bind F6 selectw -t:15
      bind F7 selectw -t:16
      bind F8 selectw -t:17
      bind F9 selectw -t:18
      bind F10 selectw -t:19
      bind F11 selectw -t:20
      bind F12 selectw -t:21
      bind c next-window
      bind C new-window -c "#{pane_current_path}"
      bind v split -hc "#{pane_current_path}"
      bind b split -vc "#{pane_current_path}"
      bind q kill-pane
      bind -n M-1 selectw -t:1
      bind -n M-2 selectw -t:2
      bind -n M-3 selectw -t:3
      bind -n M-4 selectw -t:4
      bind -n M-5 selectw -t:5
      bind -n M-6 selectw -t:6
      bind -n M-7 selectw -t:7
      bind -n M-8 selectw -t:8
      bind -n M-9 selectw -t:9
      bind -n S-Pageup copy-mode -u
      bind h set-option status
      bind t choose-tree -Zs
      bind w selectp -t :.+
      bind -n C-M-f copy-mode \; send-key ^S
      bind p display-popup
      bind S-right swap-pane -D
      bind S-left swap-pane -U
      set -g status-justify "centre"
      set -g status-left-style "none"
      set -g message-command-style "fg=#af5f5f,bg=#1c1c1c"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=#af5f5f"
      set -g status-style "none,fg=#af5f5f"
      set -g message-style "fg=#af5f5f,bg=#1c1c1c"
      set -g pane-border-style "fg=#4e4e4e"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "fg=#af5f5f,bg=#1c1c1c"
      setw -g window-status-separator ""
      setw -g window-status-style "BOLD,fg=#af5f5f,bg=#1c1c1c"
      set -g status-left ""
      set -g status-right ""
      setw -g window-status-format "#[fg=#1c1c1c,bg=#4e4e4e,nobold,nounderscore,noitalics] #I #[fg=#dfdfaf,bg=#262626] #W #[bg=#1c1c1c] "
      setw -g window-status-current-format "#[fg=#1c1c1c,bg=#af5f5f,nobold,nounderscore,noitalics] #I #[fg=#dfdfaf,bg=#262626,BOLD] #W #[bg=#1c1c1c,nobold,nounderscore,noitalics] "
    '';
  };
}