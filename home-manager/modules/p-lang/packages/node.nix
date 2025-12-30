{ config, pkgs, ... }:

let
  nodePkgs = pkgs.callPackage ./node2nix {
    inherit pkgs;
  };
in
{
  home.packages = with pkgs; [
    ni
    node2nix
    nodePkgs.zenn-cli
  ];
}
