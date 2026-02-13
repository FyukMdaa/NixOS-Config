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
    kernelPackages = pkgs.stable.linuxPackages_zen;

    # 起動時のログレベル
    consoleLogLevel = 0;

    # Plymouth (起動画面)
    plymouth.enable = true;
  };
}
