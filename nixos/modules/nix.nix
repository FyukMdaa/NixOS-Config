{ config, pkgs, lib, ... }:

{
  nix = {
    # 基本設定
    settings = {
      # 実験的機能の有効化
      experimental-features = [ "nix-command" "flakes" ];
      
      # SSL証明書の設定
      ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      
      # ストアの自動最適化
      auto-optimise-store = true;
      
      # バイナリキャッシュ
      substituters = [
        "https://cache.nixos.org"
        "https://niri.cachix.org"
      ];
      
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
      
      # ビルド設定
      max-jobs = "auto";
      cores = 0;  # すべてのコアを使用
      
      # 信頼されたユーザー
      trusted-users = [ "root" "@wheel" ];
    };
    
    # ガベージコレクション（自動クリーンアップ）
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
