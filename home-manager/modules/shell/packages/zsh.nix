{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "emacs";
    enableCompletion = true;
    autosuggestion.enable = false; # zsh-autocompleteと競合
    syntaxHighlighting.enable = false; # fast-syntax-highlightingを使用

    # Shell Options
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;
    };

    # 補完の初期化
    completionInit = ''
      autoload -Uz compinit
      setopt EXTENDEDGLOB
      local zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"

      # 24時間以内に更新されていればキャッシュを使用
      if [[ -n $zcompdump(#qNmh-24) ]]; then
        compinit -C -d "$zcompdump"
      else
        compinit -d "$zcompdump"
        { rm -f "$zcompdump.zwc" && zcompile "$zcompdump" } &!
      fi
    '';

    # プラグイン
    antidote = {
      enable = true;
      plugins = [
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "marlonrichert/zsh-autocomplete"
        "hlissner/zsh-autopair kind:defer"
      ];
    };

    # エイリアス
    shellAliases = {
      # ls系
      ls = "eza --color=always --group-directories-first --icons";
      ll = "eza -la --color=always --group-directories-first --icons --git";
      la = "eza -a --color=always --group-directories-first --icons";
      lt = "eza -aT --color=always --group-directories-first --icons --level=2";

      # cat, grep, find
      cat = "bat --style=plain --paging=never";
      grep = "rg --color=auto";
      find = "fd";

      # システム管理
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos-config#Inspiron14-5445";
      update = "nix flake update ~/.config/nixos-config";
    };

    # 初期化スクリプト
    initContent = ''
      # CORRECTを無効化
      unsetopt CORRECT

      # Shell Options
      setopt AUTO_CD
      setopt EXTENDED_GLOB
      setopt GLOB_DOTS
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_SPACE
      setopt INC_APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt INTERACTIVE_COMMENTS
      setopt NO_BEEP
      setopt PROMPT_SUBST

      # 補完設定
      zstyle ':completion:*' menu select
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:descriptions' format '%B%d%b'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:warnings' format 'No matches for: %d'
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      # zsh-autocompleteの設定
      zstyle ':autocomplete:*' min-input 2
      zstyle ':autocomplete:*' max-lines 10
      zstyle ':autocomplete:*' recent-dirs zoxide
      zstyle ':autocomplete:tab:*' widget-style menu-select
      zstyle ':autocomplete:*' list-lines 10

      # カスタム関数
      mkcd() { mkdir -p "$1" && cd "$1" }
    '';
  };

  # キャッシュディレクトリの作成
  home.activation.setupZshDirs = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p "${config.xdg.cacheHome}/zsh/zcompcache"
    $DRY_RUN_CMD mkdir -p "${config.xdg.dataHome}/zsh"
  '';
}
