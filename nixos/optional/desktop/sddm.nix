{
  pkgs,
  lib,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    wayland.compositorCommand =
      lib.mkForce
      "${pkgs.kdePackages.kwin}/bin/kwin_wayland --no-global-shortcuts --no-kactivities --locale1";
    theme = "sddm-astronaut-theme";
    extraPackages = [
      pkgs.kdePackages.kwin
      pkgs.sddm-astronaut
      pkgs.bibata-cursors
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtvirtualkeyboard
    ];
    settings = {
      Theme = {
        ThemeDir = "${pkgs.sddm-astronaut}/share/sddm/themes";
        CursorTheme = "Bibata-Modern-Classic";
        CursorSize = 24;
      };
      General = {
        GreeterEnvironment = "XCURSOR_PATH=${pkgs.bibata-cursors}/share/icons,XCURSOR_THEME=Bibata-Modern-Classic,XCURSOR_SIZE=24,QT_QUICK_BACKEND=software";
      };
    };
  };

  security.pam.services.sddm.enableGnomeKeyring = true;
}
