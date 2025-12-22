{
  description = "My NixOS and Nix-on-Droid Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
        
    nh.url = "github:viperML/nh";

    nickel.url = "github:tweag/nickel";
 
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    floorp.url = "github:fyukmdaa/floorp-flake";

    emacs-d.url = "github:fyukmdaa/.emacs.d";
    
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, sops-nix, fenix, niri, floorp, emacs-d,  nix-on-droid, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      
      overlays = [
        # Stable packages overlay
        (final: prev: {
          stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        })

        # Fenix overlay
        fenix.overlays.default
        
        # Niri overlay
        niri.overlays.niri

        # Floorp overlay
        floorp.overlays.default

        # Custom overlays
        (import ./overlays)
      ];
      
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      
      # 共通の specialArgs
      commonSpecialArgs = {
        inherit inputs;
      };
      
    in
    {
      # NixOS Configurations
      nixosConfigurations = {
        Inspiron14-5445 = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = commonSpecialArgs // { 
            hostname = "Inspiron14-5445";
          };
          modules = [
            ./hosts/Inspiron14-5445
            ./nixos

            sops-nix.nixosModules.sops
            
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.fyukmdaa = import ./home-manager/users/fyukmdaa;
                extraSpecialArgs = commonSpecialArgs // {
                  isDesktop = true;
                };
              };
            }
          ];
        };
      };
      
      # Nix-on-Droid Configuration
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs { 
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ./nix-on-droid
          {
            home-manager = {
              config = import ./home-manager/users/fyukmdaa;
              extraSpecialArgs = commonSpecialArgs // {
                isDesktop = false;
              };
            };
          }
        ];
      };
    };
}
