{ config, pkgs, lib, ... }:
{
  # .config/nix ディレクトリの作成
  systemd.tmpfiles.rules = [
    "d /home/fyukmdaa/.config/nix 0755 fyukmdaa users -"
  ];

  nix = {
    # 基本設定
    settings = {
      # 実験的機能の有効化
      experimental-features = [ "nix-command" "flakes" ];
      # SSL証明書の設定
      ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      # ストアの自動最適化
      auto-optimise-store = true;
      # ビルド設定
      max-jobs = "auto";
      cores = 0;  # すべてのコアを使用
      # 信頼されたユーザー
      trusted-users = [ "root" "@wheel" ];
    };
    
    # GitHub api制限の回避
    extraOptions = ''
      !include ${config.sops.secrets.github_token.path}
    '';
    
    # ガベージコレクション(自動クリーンアップ)
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # ストア最適化の自動実行
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
}
