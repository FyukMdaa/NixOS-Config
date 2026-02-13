{...}: {
  hardware.facter.reportPath = ./facter.json;

  imports = [
    # ハードウェア設定をインポート
    ./hardware-configuration.nix
  ];

  # ついでに stateVersion もここで設定して警告を消す
  system.stateVersion = "26.05";
}
