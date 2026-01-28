{
	# OpenGL/Graphics
	hardware.graphics.enable = true;

	# QMK
	hardware.keyboard.qmk.enable = true;

	# Bluetooth
	hardware.bluetooth = {
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
}
