{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh.url = "github:viperML/nh";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    floorp.url = "github:fyukmdaa/floorp-flake";
    skk-dict.url = "github:fyukmdaa/skk-dict-flake";
    twist.url = "github:emacs-twist/twist.nix";
    emacs-d.url = "github:fyukmdaa/emacs-config";
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, ... }: {

      systems = [ "x86_64-linux" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        formatter = pkgs.alejandra;
      };

      flake.nixosConfigurations.Inspiron14-5445 = withSystem "x86_64-linux" ({ pkgs, inputs', system, ... }:  # ← inputs' を受け取る
        let
          customPkgs = import top.inputs.nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                stable = import top.inputs.nixpkgs-stable {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
              top.inputs.fenix.overlays.default
              top.inputs.niri.overlays.niri
              top.inputs.floorp.overlays.default
              top.inputs.skk-dict.overlays.default
              (import ./overlays)
            ];
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          pkgs = customPkgs;

          specialArgs = {
            inherit (top) inputs;
            hostname = "Inspiron14-5445";
          };

          modules = [
            ./hosts/Inspiron14-5445
            ./nixos
            top.inputs.sops-nix.nixosModules.sops
            top.inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                sharedModules = [ top.inputs.sops-nix.homeManagerModules.sops ];
                users.fyukmdaa = import ./home-manager/users/fyukmdaa;
                extraSpecialArgs = {
                  inherit (top) inputs;
                  inherit (top.inputs) emacs-d;
                };
              };
            }
          ];
        }
      );

    });
}
