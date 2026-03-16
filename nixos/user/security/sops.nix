{config, ...}: {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;

    secrets.github_token = {
      owner = config.users.users.fyukmdaa.name;
      inherit (config.users.users.fyukmdaa) group;
      mode = "0600";
      path = "/home/fyukmdaa/.config/nix/github-token";
    };
  };
}
