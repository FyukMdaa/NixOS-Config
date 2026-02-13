{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.nixos-facter.nixosModules.facter
  ];
}
