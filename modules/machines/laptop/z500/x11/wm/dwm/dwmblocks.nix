{
  pkgs,
  lib,
  ...
}:
let
  dwmblocks-async = pkgs.stdenv.mkDerivation {
    pname = "dwmblocks-async";
    version = "0-unstable-2026-04-18";
    #version = "unstable-2026-04-18";

    src = pkgs.fetchFromGitHub {
      owner = "UtkarshVerma";
      repo = "dwmblocks-async";
      rev = "469e6841432693d81a17088706d99ef044a29936";
      hash = "sha256-gACpUAFVT/6Z9IvWQQ+IW7vNG7kzgJeVkXXMJeuw1V0=";
    };

    strictDeps = true;

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      libxcb
      xcbutil
    ];

    # this would look for a path with the config file, a string containing the code of the config
    #postPatch =
    #  let
    #    configFile =
    #      if lib.isDerivation conf || builtins.isPath conf then conf else pkgs.writeText "config.h" conf;
    #  in
    #  lib.optionalString (conf != null) "cp ${configFile} config.h";

    postPatch = ''
      cp ${../../../../../../../config/dwmblocks-async/config.h} config.h
    '';

    makeFlags = [ "PREFIX=$(out)" ];

    meta = {
      description = "A fast, asynchronous and feature-rich implementation of dwmblocks";
      homepage = "https://github.com/utkarshverma/dwmblocks-async";
      license = lib.licenses.gpl2Only;
      platforms = lib.platforms.linux;
      mainProgram = "dwmblocks";
    };
  };
in
{
  environment.systemPackages = [
    dwmblocks-async
  ];

  systemd.user.services.dwmblocks = {
    description = "dwmblocks-async status bar";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${dwmblocks-async}/bin/dwmblocks";
      Restart = "always";
      RestartSec = "3s";

      Slice = "session.slice";
      TimeoutStopSec = "5s";
    };
  };
}
