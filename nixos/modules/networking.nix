{ hostname, pkgs, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    
    # DNS設定
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
    
    # ファイアウォール
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ];
    };
  };
}
