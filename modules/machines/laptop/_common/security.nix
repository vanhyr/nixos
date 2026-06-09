{
  lib,
  ...
}:
{
  security = {
    doas = {
      enable = lib.mkDefault true;
      wheelNeedsPassword = lib.mkDefault true;
      extraRules = [
        {
          groups = [ "wheel" ];
          persist = true;
          keepEnv = true;
        }
      ];
    };
    sudo = {
      enable = lib.mkDefault false;
      #wheelNeedsPassword = lib.mkDefault false;
    };
  };
}
