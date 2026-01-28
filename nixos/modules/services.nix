{
  pkgs,
  inputs,
  ...
}: {
  # Niri (Wayland Compositor)
  imports = [inputs.niri.nixosModules.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };

  # Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # X Server (fallback)
  services.xserver = {
    enable = true;
    xkb = {
      layout = "jp";
      variant = "";
    };
  };

  # 印刷
  services.printing.enable = true;

  # 音声
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # その他のサービス
  services = {
    # DBus
    dbus.enable = true;
    # UPower
    upower.enable = true;
    # GNOME Keyring
    gnome.gnome-keyring.enable = true;
  };

  # セキュリティ
  security.pam.services.sddm.enableGnomeKeyring = true;

  # XDG Portal (スクリーンシェア等に必要)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  services.udev = {
  
    packages = with pkgs; [
      qmk
      qmk-udev-rules # the only relevant
      qmk_hid
      via
      vial
    ]; # packages
  
  }; # udev
}
