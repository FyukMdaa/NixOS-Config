{pkgs, ...}: {
  services = {
    # Display Manager
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # X Server (fallback)
    xserver = {
      enable = true;
      xkb = {
        layout = "jp";
        variant = "";
      };
    };

    # 印刷
    printing.enable = true;

    # 音声
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    udisks2.enable = true;

    udev = {
      enable = true;
      packages = with pkgs; [
        qmk
        qmk-udev-rules
        qmk_hid
        via
      ];
    };

    # DBus
    dbus.enable = true;
    # UPower
    upower.enable = true;
    # GNOME Keyring
    gnome.gnome-keyring.enable = true;
  };

  # XDG Portal (スクリーンシェア等に必要)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };
}
