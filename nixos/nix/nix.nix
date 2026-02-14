{
  config,
  pkgs,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /home/fyukmdaa/.config/nix 0755 fyukmdaa users -"
  ];

  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    settings = {
      experimental-features = ["nix-command" "flakes" "cgroups"];
      ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      auto-optimise-store = true;
      max-jobs = "auto";
      cores = 0;
      trusted-users = ["root" "@wheel"];
      builders-use-substitutes = true;
      use-cgroups = true;
      use-xdg-base-directories = true;
    };

    extraOptions = ''
      !include ${config.sops.secrets.github_token.path}
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };
}
