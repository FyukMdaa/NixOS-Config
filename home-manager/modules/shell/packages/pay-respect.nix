{ config, pkgs, ... }:

{
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };
}
