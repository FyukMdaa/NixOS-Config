{
  hostname,
  pkgs,
  ...
}: {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    networkmanager.dns = "default"; 

    # DNS設定
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    # ファイアウォール
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
    };
  };
}
