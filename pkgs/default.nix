{inputs, ...}: {
  perSystem = {system, ...}: let
    overlays = [
      # nixpkgs-stable
      (_final: _prev: {
        stable = import inputs.nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      })

      inputs.fenix.overlays.default
      inputs.niri.overlays.niri
      inputs.floorp.overlays.default
      inputs.skk-dict.overlays.default
      (import ./overlays)
    ];
  in {
    # nixpkgs を設定
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  };
}
