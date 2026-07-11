{
  pkgs,
  ...
}:
let
  python3 = pkgs.python3;

  selenium-wire-2 = python3.pkgs.buildPythonPackage rec {
    pname = "selenium-wire-2";
    version = "0.2.1";
    pyproject = true;

    src = pkgs.fetchFromGitHub {
      owner = "7x11x13";
      repo = "selenium-wire-2";
      rev = "v${version}";
      hash = "sha256-3ND7Uv14wqKj38DN5mNZsYj3y/RlwuuGjXH4qkNZU9I=";
    };

    build-system = with python3.pkgs; [
      setuptools
    ];

    dependencies = with python3.pkgs; [
      selenium
      mitmproxy
    ];

    doCheck = false;

    pythonImportsCheck = [ "seleniumwire2" ];

    meta = with pkgs.lib; {
      description = "A selenium-wire fork with active support";
      homepage = "https://github.com/7x11x13/selenium-wire-2";
      license = licenses.mit;
    };
  };

  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      selenium
      selenium-wire-2
    ]
  );
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    python-packages

    pyright
    ruff
  ];

  env = {
    PYTHONBREAKPOINT = "ipdb.set_trace";
  };

  shellHook = ''
    echo "🐍 Python environment loaded"
  '';
}
