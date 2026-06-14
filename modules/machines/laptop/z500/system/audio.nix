{
  ...
}:
{
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        #"10-bluez-hard-fix" = {
        #  "monitor.bluez.properties" = {
        #    #"bluez5.roles" = [
        #    #  "a2dp_sink"
        #    #  "a2dp_source"
        #    #];
        #    "bluez5.hfphsp-backend" = "none";
        #    "bluez5.enable-midi" = false;
        #  };
        #};
        "11-bluetooth-policy" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
    };
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };
}
