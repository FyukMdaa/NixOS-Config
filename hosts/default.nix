{
  inputs,
  withSystem,
  self,
  lib,
  ...
}: let
  hostNames = builtins.attrNames (lib.filterAttrs (_n: v: v == "directory") (builtins.readDir ./.));
in {
  flake.nixosConfigurations = lib.genAttrs hostNames (
    hostname:
      withSystem "x86_64-linux" (
        {pkgs, ...}:
          inputs.nixpkgs.lib.nixosSystem {
            inherit pkgs;

            specialArgs = {
              inherit inputs self;
              inherit hostname;
              inherit (inputs) emacs-d;
            };

            modules = [
              ./${hostname}
              self.nixosModules.default

              # 外部モジュール
              inputs.sops-nix.nixosModules.sops
              inputs.niri.nixosModules.niri
              inputs.nixos-facter.nixosModules.facter
            ];
          }
      )
  );
}
