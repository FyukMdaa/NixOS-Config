{
  config,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };

  # SSH agentを有効化
  services.ssh-agent.enable = true;
}
