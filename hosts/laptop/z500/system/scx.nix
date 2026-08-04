{
  pkgs,
  ...
}:
{
  # needs kernel 6.12 or above
  services.scx = {
    enable = true;
    #enable = false;
    package = pkgs.scx.full;
    # scx_bpfland (lightweight for simple hardware)
    scheduler = "scx_bpfland";
    # scx_lavd (max performance)
    #scheduler = "scx_lavd";
    #extraArgs = [ "--performance" ];
    # scx_rusty (max graphics)
    #scheduler = "scx_rusty";
  };
}
