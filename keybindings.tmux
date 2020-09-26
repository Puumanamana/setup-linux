unbind-key -n F1
bind-key -n F1 display-panes \; new-window -c "#{pane_current_path}" -n -
unbind-key -n F2
bind-key -n F2 display-panes \; split-window -hc "#{pane_current_path}"
unbind-key -n S-F2
bind-key -n S-F2 display-panes \; split-window -vc "#{pane_current_path}"
unbind-key %
bind-key % display-panes \; split-window -hc "#{pane_current_path}"
unbind-key |
bind-key | display-panes \; split-window -vc "#{pane_current_path}"set -g prefix F12
unbind-key -n C-a

unbind -n M-Right
unbind -n M-Left