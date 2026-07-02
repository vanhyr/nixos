{
  pkgs,
  ...
}:
{
  # needs kernel 6.12 or above
  services.scx = {
    enable = true;
    scheduler = "scx_bpfland"; # lighwheight for simple hardware

    #scheduler = "scx_lavd"; # max performance
    #extraArgs = [ "--performance" ];

    #scheduler = "scx_rusty"; # max graphics

    package = pkgs.scx.full; # pkgs.scx_git.full (latest version)
  };
}
