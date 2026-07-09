{
  lib,
  ...
}:
{
  imports = [
    # manual imports in case they are needed
  ]
  ++ (
    let
      dir = ./.;
      content = builtins.readDir dir;

      blacklist = [
        "default.nix"
      ];

      isValidNix =
        name: type: (type == "regular" && lib.hasSuffix ".nix" name && !lib.elem name blacklist);

      filteredContent = lib.filterAttrs isValidNix content;
    in
    lib.mapAttrsToList (name: type: dir + "/${name}") filteredContent
  );
}
