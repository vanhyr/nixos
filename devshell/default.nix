{
  pkgs,
  ...
}:
let
  shells = {
    default = [ "python" ];
    python = [ "python" ];
    # add new ones with: rust = [ "rust" ]; node = [ "node" ]; etc.
  };

  loadModule = name: import ./${name}.nix { inherit pkgs; };

  buildShell =
    name: modList:
    let
      customFile = ./${name}.nix;
      isBaseModule = modList == [ name ];
      hasCustom = !isBaseModule && builtins.pathExists customFile;
      modules = map loadModule modList;
      custom = if hasCustom then import customFile { inherit pkgs; } else { };
    in
    pkgs.mkShell {
      inputsFrom = modules ++ (custom.inputsFrom or [ ]);
      buildInputs = custom.packages or [ ];
      nativeBuildInputs = custom.nativeBuildInputs or [ ];
      env = custom.env or { };
      shellHook = custom.shellHook or "";
    };
in
builtins.mapAttrs buildShell shells
