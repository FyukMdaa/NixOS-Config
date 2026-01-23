{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # Zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # ファイルシステムサポート
    supportedFilesystems = ["xfs" "btrfs" "ntfs"];

    # 起動時のログレベル
    consoleLogLevel = 3;

    # Plymouth (起動画面)
    # plymouth.enable = true;
  };
}
