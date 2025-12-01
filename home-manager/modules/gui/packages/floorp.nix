{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    floorp
  ];

  # Floorpの環境変数
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
