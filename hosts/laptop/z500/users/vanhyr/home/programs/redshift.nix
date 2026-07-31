{
  osConfig,
  ...
}:
{
  services.redshift = {
    enable = true;
    tray = false;

    provider = "manual";
    latitude = toString osConfig.location.latitude;
    longitude = toString osConfig.location.longitude;

    # Default temperature is 6500:4500, adjust to your liking
    temperature = {
      day = 6500; # 5500
      #day = 6000; # 5500
      night = 3500; # 3000
    };
  };
}
