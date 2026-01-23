{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "emacs";
    prefix = "C-t";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;

    extraConfig = ''
      # マウス操作を有効化
      set -g mouse on

      # ステータスバーの設定
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'bg=#1a1b26 fg=#c0caf5'

      # ペイン分割のキーバインド
      bind h split-window -h
      bind v split-window -v
      unbind '"'
      unbind %

      # ペイン移動のキーバインド
      bind b select-pane -L
      bind n select-pane -D
      bind p select-pane -U
      bind f select-pane -R

      # ウィンドウ移動のキーバインド
      bind -n M-Left previous-window
      bind -n M-Right next-window

      # リロード
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
    '';
  };
}
