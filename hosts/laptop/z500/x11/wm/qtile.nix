{
  ...
}:
{
  # https://github.com/NixOS/nixpkgs/issues/559128
  # https://github.com/NixOS/nixpkgs/pull/559192
  services.xserver.windowManager.qtile = {
    enable = true;
    #package = pkgs.python3.pkgs.qtile; #default
    extraPackages = ps: with ps; [
      qtile-extras
    ];
  };
  # qtile-extras tests are broken, temporal fix: disable tests
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pyFinal: pyPrev: {
          qtile-extras = pyPrev.qtile-extras.overridePythonAttrs { doCheck = false; };
        })
      ];
    })
  ];
}
