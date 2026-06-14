{
  ...
}:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];

    #autoRepeatDelay = 200;
    #autoRepeatInterval = 35;

    xkb = {
      model = "pc105"; # europe ISO, TODO -> or pc104 (is it trully ANSI US?)
      layout = "es";
      options = "caps:escape";
    };
  };
}
