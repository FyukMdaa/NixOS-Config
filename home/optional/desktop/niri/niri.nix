{ pkgs, ... }: {
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    xwayland-satellite
    bibata-cursors
    brightnessctl
    swww
    ghostty
    wofi
    wireplumber
  ];
}
