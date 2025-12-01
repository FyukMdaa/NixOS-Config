{ config, pkgs, ... }:

{
  imports = [
    ./modules/boot.nix
    ./modules/cachix.nix
    ./modules/fonts.nix
    ./modules/i18n.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/services.nix
    ./modules/systemd.nix
    ./modules/time.nix
    ./modules/users.nix
  ];
  
  # Nix設定
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  # システムバージョン
  system.stateVersion = "25.05";
}
