{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # システムツール
    git
    wget
    curl
    htop
    btop
    procps
    killall
    # Bluetooth
    bluetui
    # NixOSツール
    cachix
    nh
    sops
    nix-prefetch-git
    nix-inspect
    nurl
    nix-health
    nix-index
    nvd
    statix
    deadnix
    lix.nix-init
    lix.nix-direnv
    lix.nix-update
    lix.nix-eval-jobs
    lix.nix-fast-build
    # エディタ
    micro
    helix
    # ファイル管理
    zip
    unzip
    bzip2
    gzip
    xz
    udisks
    # その他
    fastfetch
    # QMK
    qmk
    dfu-util
    via
  ];

  programs.zsh.enable = true;
}
