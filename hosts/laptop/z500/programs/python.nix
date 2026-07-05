{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        #requests
        #selenium
        #selenium-wire
        #(selenium-wire.overridePythonAttrs (oldAttrs: {
        #  doCheck = false;
        #  meta = oldAttrs.meta // {
        #    broken = false;
        #  };
        #}))
      ]
    ))
  ];
}
