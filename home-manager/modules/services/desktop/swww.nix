{ config, pkgs, ... }:

{
  # swwwパッケージ
  home.packages = with pkgs; [
    swww
  ];
  
  # wallpapersディレクトリの画像をコピー
  xdg.configFile."wallpapers/nixos-wall.png".source = ./wallpapers/nixos-wall.png;
  
}
