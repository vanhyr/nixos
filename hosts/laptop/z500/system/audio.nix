{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wiremix
    pamixer
    pavucontrol
    pulsemixer
    playerctl # mpris
  ];

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
        #extraConfig = {
        #  "11-bluetooth-policy" = {
        #    "wireplumber.settings" = {
        #      "bluetooth.autoswitch-to-headset-profile" = false;
        #    };
        #  };
        #};
      };
    };
  };

  security.rtkit.enable = true;
}
