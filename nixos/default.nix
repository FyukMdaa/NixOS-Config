{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/boot.nix
    ./modules/cachix.nix
    ./modules/fonts.nix
    ./modules/i18n.nix
    ./modules/networking.nix
    ./modules/nix.nix
    ./modules/packages.nix
    ./modules/security.nix
    ./modules/services.nix
    ./modules/sops.nix
    ./modules/systemd.nix
    ./modules/time.nix
    ./modules/users.nix
  ];

  # システムバージョン
  system.stateVersion = "25.05";
}
