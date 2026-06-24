{
  pkgs,
  ...
}:
{
  services.xserver = {
    windowManager = {
      dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs (oldAttrs: {
          src = pkgs.lib.cleanSource ../../../../../../config/dwm;
          buildInputs = (oldAttrs.buildInputs or [ ]) ++ [
            pkgs.libxcb
          ];
        });
      };
    };
  };
}
