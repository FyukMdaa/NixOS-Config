{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pay-respects
  ];
}
