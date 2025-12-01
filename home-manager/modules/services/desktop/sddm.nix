{ config, pkgs, ... }:

{
  # SDDMはNixOSモジュールで設定されるため、
  # ここではhome-manager固有の設定のみ
  
  # SDDMテーマ用のパッケージ（必要に応じて）
  # home.packages = with pkgs; [
  #   sddm-theme-name
  # ];
}
