{pkgs, ...}: {
  home.packages = with pkgs; [
    ghostty
  ];
  home.file.".config/ghostty" = {
    recursive = true;
    source = ./config;
  };
}
