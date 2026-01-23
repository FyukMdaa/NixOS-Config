{
  config,
  pkgs,
  isDesktop ? false,
  inputs,
  ...
}: {
  imports = [
    ./modules/emacs
    ./modules/shell
    ./modules/gui
    ./modules/p-lang
    ./modules/services
  ];
}
