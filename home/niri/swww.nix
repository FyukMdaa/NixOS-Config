{pkgs, ...}: {
  # swwwパッケージ
  home.packages = with pkgs; [
    swww
  ];

  xdg.portal.config.common.default = "*";
}
