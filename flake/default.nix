{inputs, ...}: {
  flake = {
    nixosModules.default = {
      imports = [(inputs.import-tree ../nixos)];
    };

    homeModules.default = {
      imports = [(inputs.import-tree ../home)];
    };
  };
}
