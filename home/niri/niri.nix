{
  config,
  pkgs,
  ...
}: {
  programs.niri.package = pkgs.niri-stable;

  programs.niri.settings = {
    # 入力デバイス
    input = {
      keyboard = {
        xkb = {
          layout = "jp";
        };
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true;
        accel-speed = 0.3;
      };

      mouse = {
        natural-scroll = false;
        accel-speed = 0.0;
      };
    };

    # ディスプレイ設定
    outputs = {
      "eDP-1" = {
        scale = 1.0;
      };
    };

    # レイアウト設定
    layout = {
      gaps = 8;
      center-focused-column = "never";

      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];

      default-column-width = {proportion = 1.0 / 2.0;};

      border = {
        enable = true;
        width = 2;
        active.color = "#7dcfff";
        inactive.color = "#414868";
      };

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#7dcfff";
        inactive.color = "#414868";
      };
    };

    # 環境変数
    environment = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };

    # 起動時実行
    spawn-at-startup = [
      # mako を削除し、swaync を起動
      { command = ["swaync"]; }
      
      # swayosd-server を起動
      { command = ["swayosd-server"]; }
      
      { command = ["fcitx5" "-d"]; }
      { command = ["swww-daemon"]; }
    ];

    # ワークスペース
    workspaces = {
      "1" = {};
      "2" = {};
      "3" = {};
      "4" = {};
      "5" = {};
    };

    # キーバインド
    binds = with config.lib.niri.actions; {
      # 基本操作
      "Mod+Return".action.spawn = ["ghostty"];
      "Mod+D".action.spawn = ["wofi" "--show" "drun"];
      "Mod+Q".action.close-window = {};
      "Mod+O".action.toggle-overview = {};

      # SwayNC トグル (通知センターを開く)
      "Mod+T".action.spawn = [ "swaync-client" "-t" ];

      # ウィンドウフォーカス
      "Mod+B".action.focus-column-left = {};
      "Mod+F".action.focus-column-right = {};
      "Mod+N".action.focus-window-down = {};
      "Mod+P".action.focus-window-up = {};

      # ウィンドウ移動
      "Mod+Shift+B".action.move-column-left = {};
      "Mod+Shift+F".action.move-column-right = {};
      "Mod+Shift+N".action.move-window-down = {};
      "Mod+Shift+P".action.move-window-up = {};

      # ウィンドウサイズ調整
      "Mod+Ctrl+B".action.set-column-width = "-10%";
      "Mod+Ctrl+F".action.set-column-width = "+10%";
      "Mod+Ctrl+N".action.set-window-height = "+10%";
      "Mod+Ctrl+P".action.set-window-height = "-10%";

      # プリセット幅
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+M".action.maximize-column = {};
      "Mod+Shift+M".action.fullscreen-window = {};


      # ウィンドウをワークスペースに移動
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;

      # ワークスペースフォーカス
      "Mod+G".action.focus-workspace-up = {};
      "Mod+V".action.focus-workspace-down = {};

      # モニター間移動
      "Mod+Comma".action.focus-monitor-left = {};
      "Mod+Period".action.focus-monitor-right = {};
      "Mod+Shift+Comma".action.move-column-to-monitor-left = {};
      "Mod+Shift+Period".action.move-column-to-monitor-right = {};

      # システム
      "Mod+Shift+E".action.quit = {};

      # スクリーンショット
      "Print".action.screenshot = {};
      "Shift+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      # 音量調整
      "XF86AudioRaiseVolume".action.spawn = [ "swayosd-client" "--output-volume" "raise" ];
      "XF86AudioLowerVolume".action.spawn = [ "swayosd-client" "--output-volume" "lower" ];
      "XF86AudioMute".action.spawn = [ "swayosd-client" "--output-volume" "mute-toggle" ];

      # 明るさ調整
      "XF86MonBrightnessUp".action.spawn = [ "swayosd-client" "--brightness" "raise" ];
      "XF86MonBrightnessDown".action.spawn = [ "swayosd-client" "--brightness" "lower" ];
    };

    # カーソルテーマ
    cursor = {
      theme = "Bibata-Modern-Classic";
      size = 24;
    };

    # アニメーション
    animations = {
      slowdown = 1.0;

      workspace-switch.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };

      window-open.kind.easing = {
        duration-ms = 150;
        curve = "ease-out-cubic";
      };

      window-close.kind.easing = {
        duration-ms = 150;
        curve = "ease-out-cubic";
      };

      window-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };

      horizontal-view-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };

    # ウィンドウルール
    window-rules = [
      {
        matches = [
          {app-id = "^org.keepassxc.KeePassXC$";}
        ];
        default-column-width = {proportion = 0.5;};
      }
      
      # --- 角丸除外ルールの例 (必要に応じて) ---
      # 例: YouTube全画面表示時などは角丸を解除したほうが見栄えが良い場合
      # {
      #   matches = [
      #     { app-id = ".*"; } # 全ウィンドウ対象にして除外ロジックを組むか、特定アプリのみ
      #   ];
      #   # 全画面時は自動で解除されることが多いですが、
      #   # 特定アプリで角丸を無効にしたい場合はここに excludes を書きます。
      # }
    ];
  };

  # 必要なパッケージ
  home.packages = with pkgs; [
    xwayland-satellite
    bibata-cursors

    # その他ユーティリティ
    brightnessctl # swayosdが内部で使用する場合があるため残しておくのが無難
    swww
    ghostty
    wofi
    wireplumber
  ];
}
