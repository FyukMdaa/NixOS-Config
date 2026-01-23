{
  config,
  pkgs,
  ...
}: {
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      ".git/"
      "node_modules/"
    ];
  };
}
