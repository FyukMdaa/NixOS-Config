{ config, pkgs, isDesktop ? false, inputs, ... }:

{
  imports = [
    ./modules/shell
    ./modules/emacs
    ./modules/gui
    ./modules/services
  ];
}
