{pkgs, ...}: {
  home.packages = with pkgs; [
    floorp-bin
  ];

  # Floorpの環境変数
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
