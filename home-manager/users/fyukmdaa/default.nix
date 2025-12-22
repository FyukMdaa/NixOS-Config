{ config, pkgs, emacs-d, isDesktop ? false, inputs, ... }:

{
  imports = [ 
    ../../default.nix
    inputs.twist.homeModules.emacs-twist
  ];
  
  home = {
    username = "fyukmdaa";
    homeDirectory = "/home/fyukmdaa";
    stateVersion = "25.05";
  };
  
  programs.home-manager.enable = true;
  
  # XDG設定
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
  
  # 環境変数
  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
  };
}
