{ config, pkgs, isDesktop ? false, inputs, ... }:

{
  imports = [
    ./modules/shell
    ./modules/gui
    ./modules/p-lang
    ./modules/services
  ];
}
