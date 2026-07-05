{
  pkgs,
  ...
}:
let
  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      selenium
      #selenium-wire
      #(selenium-wire.overridePythonAttrs (oldAttrs: {
      #  doCheck = false;
      #  meta = oldAttrs.meta // {
      #    broken = false;
      #  };
      #}))
    ]
  );
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    python-packages
    pyright
  ];

  env = {
    PYTHONBREAKPOINT = "ipdb.set_trace";
  };

  shellHook = ''
    echo "🐍 Python environment loaded"
    #if [ ! -d .venv ]; then
    #  echo "Creando entorno virtual en .venv..."
    #  python -m venv .venv
    #</if>
    #source .venv/bin/activate
  '';
}
