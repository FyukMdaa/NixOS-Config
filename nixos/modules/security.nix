{pkgs, ...}: {
  #SSL証明書
  security.pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  ];
}
