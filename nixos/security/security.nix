{pkgs, ...}: {
  security = {
    #SSL証明書
    pki.certificateFiles = [
      "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    ];
    rtkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
  };
}
