{pkgs, ...}: {
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
    nix-inspect
    nix-update
    nix-output-monitor
    nix-init
    nurl
    nix-health
    nix-index
    nvd
    statix
    deadnix

    # エディタ
    micro
    vim

    # ファイル管理
    zip
    unzip

    # その他
    fastfetch
    qmk
    via
    dfu-util
    vial
  ];

  # システムワイドで有効化するプログラム
  programs = {
    zsh.enable = true;
  };
}
