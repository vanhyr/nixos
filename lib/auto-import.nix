{
  dir,
  exclude ? [ ],
  extraImports ? [ ],
  mainFiles ? [
    "default.nix"
    "configuration.nix"
  ],
}:
let
  entries = builtins.readDir dir;

  names = builtins.sort builtins.lessThan (builtins.attrNames entries);

  isExcluded = name: builtins.elem name exclude;

  autoImports = builtins.concatMap (
    name:
    let
      type = entries.${name};
      path = dir + "/${name}";
    in

    if isExcluded name then
      [ ]

    else if
      type == "regular" && builtins.match ".*\\.nix" name != null && !(builtins.elem name mainFiles)
    then
      [ path ]
    else if type == "directory" then
      builtins.concatMap (
        mainFile:
        let
          candidate = path + "/${mainFile}";
        in
        if builtins.pathExists candidate then [ candidate ] else [ ]
      ) mainFiles

    else
      [ ]
  ) names;
in
autoImports ++ extraImports
