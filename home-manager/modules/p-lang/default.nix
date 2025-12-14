{ config, pkgs, ... }:

{
  imports = [
    ./packages/rust.nix
  ];
}
