{
  hardware = {
    # OpenGL/Graphics
    graphics.enable = true;

    # QMK
    keyboard.qmk.enable = true;

    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
