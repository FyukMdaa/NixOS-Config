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
    sops
    nix-prefetch-git

    # エディタ
    micro
    vim

    # ファイル管理
    zip
    unzip

    # その他
    fastfetch
  ];

  # システムワイドで有効化するプログラム
  programs = {
    zsh.enable = true;
  };
}
