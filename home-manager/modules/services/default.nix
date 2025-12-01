{ config, pkgs, inputs, ... }:

{
  imports = [
    ./desktop/niri.nix
    ./desktop/sddm.nix
    ./desktop/wofi.nix
    ./desktop/swww.nix
  ];
}
