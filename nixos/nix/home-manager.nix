{
  inputs,
  self,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.fyukmdaa = {
      imports = [self.homeModules.default];
      home.stateVersion = "26.05";
    };

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    extraSpecialArgs = {
      inherit inputs self;
    };
  };
}
