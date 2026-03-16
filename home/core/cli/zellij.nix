{pkgs, ...}: {
  home.packages = with pkgs; [
    zellij
  ];

  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  # aliases
  home.shellAliases = {
    ze = "zellij";
    zn = "zellij --session";
    zk = "zellij kill-session";
    zd = "zellij delete-session";
    zda = "zellij delete-all-sessions";
    zlist = "zellij list-sessions";
    zls = "zellij list-sessions";
  };
}
