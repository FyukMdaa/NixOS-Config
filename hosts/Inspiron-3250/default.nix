{ config, pkgs, inputs, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];
  
  # ホスト固有の設定
  # 例: 特殊なハードウェア設定、モニター設定など
}
