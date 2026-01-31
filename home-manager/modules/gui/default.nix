{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages/floorp.nix
  ];

  # GUI用の基本パッケージ
  home.packages = with pkgs; [
    # ターミナル
    ghostty

    # ファイルマネージャー
    nemo

    # 画像ビューア
    imv

    # 動画プレイヤー
    mpv

    # PDFビューア
    zathura

    # その他
    pavucontrol # 音量調整
    networkmanagerapplet
  ];
}
