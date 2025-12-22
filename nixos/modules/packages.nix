{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # システムツール
    git
    wget
    curl
    htop
    btop
    bluez
    bluetui

    # NixOSツール
    cachix
    nh
    nixel
    nickel
    
    # エディタ
    micro
    vim
    
    # ファイル管理
    tree
    zip
    unzip
    
    # その他
    fastfetch
    input-remapper
  ];
  
  # システムワイドで有効化するプログラム
  programs = {
    zsh.enable = true;
  };
}
