{
  ...
}:
{
  # Check fails, workaround for now (TODO -> look into it)
  #nixpkgs.overlays = [
  #  (final: prev: {
  #    #qtile = prev.qtile.overrideAttrs (_: {
  #    #  doCheck = false;
  #    #});
  #    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
  #      (python-final: python-prev: {
  #        qtile-extras = python-prev.qtile-extras.overridePythonAttrs (_: {
  #          doCheck = false;
  #        });
  #        #qtile = python-prev.qtile.overrideAttrs (_: {
  #        #  doCheck = false;
  #        #});
  #      })
  #    ];
  #  })
  #];
  #environment.systemPackages = with pkgs; [
  #  python313Packages.mypy
  #  #mypy
  #];
  services.xserver.windowManager.qtile = {
    #enable = true; # not passing tests, disabled for now (TODO -> fix)
    enable = false;
    #package = pkgs.python3.pkgs.qtile; #default
    #package = pkgs.python313Packages.qtile;
    extraPackages = ps: with ps; [
      qtile-extras
    ];
  };
}
