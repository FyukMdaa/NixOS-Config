{ pkgs, ... }:

{
  # ロケール設定
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    
    extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASUREMENT = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UTF-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };
    
    # 日本語入力 (Fcitx5)
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-skk
          fcitx5-mozc
        ];
        waylandFrontend = true;
      };
    };
  };
  
  # コンソール設定
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };
}
