{pkgs, ...}: {
  users.users.fyukmdaa = {
    isNormalUser = true;
    description = "fyukmdaa";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "plugdev"
      "dialout"
      "uinput"
      "input"
    ];
  };
}
