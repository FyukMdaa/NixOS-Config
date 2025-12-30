{ config, pkgs, ... }:

{
  imports = [
    ./packages/rust.nix
    ./packages/node.nix
  ];
}
