{ config, pkgs, ... }:

{
  imports = [
    ./packages/bat.nix
    ./packages/eza.nix
    ./packages/fd.nix
    ./packages/fzf.nix
    ./packages/git.nix
    ./packages/ripgrep.nix
    ./packages/starship.nix
    ./packages/tmux.nix
    ./packages/wget.nix
    ./packages/yazi.nix
    ./packages/zoxide.nix
    ./packages/zsh.nix
  ];
}
