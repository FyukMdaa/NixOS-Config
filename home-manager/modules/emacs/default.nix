{ config, pkgs, emacs-d, ... }:
{
  programs.emacs-twist = {
    enable = true;
    emacsclient.enable = true;
    createInitFile = true;
    createManifestFile = true;

    config = emacs-d.packages.${pkgs.system}.default;
  };
}
