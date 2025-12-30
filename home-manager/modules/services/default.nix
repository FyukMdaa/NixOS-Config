{ config, pkgs, inputs, ... }:

{
  imports = [
    ./desktop/eww.nix
    ./desktop/niri.nix
    ./desktop/sddm.nix
    ./desktop/swaync.nix
    ./desktop/swayosd.nix
    ./desktop/wofi.nix
    ./desktop/swww.nix
  ];
}
