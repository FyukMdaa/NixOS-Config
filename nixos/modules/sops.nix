{ config, pkgs, ... }:

{
  sops.age.keyFile = "~/.config/sops/age/keys.txt";

  # デフォルトのsecretsファイル
  sops.defaultSopsFile = ../../secrets/ssh.yaml;

  sops.secrets.github_ssh_key = {
    owner = config.users.users.fyukmdaa.name;
    group = config.users.users.fyukmdaa.group;
    mode = "0600";
    path = "/home/fyukmdaa/.ssh/id_ed25519";
  };
}
