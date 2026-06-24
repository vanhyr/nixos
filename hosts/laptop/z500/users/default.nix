{
  ...
}:
let
  dirContents = builtins.readDir ./.;
  users = builtins.filter (
    name: dirContents.${name} == "directory" && builtins.pathExists (./. + "/${name}/default.nix")
  ) (builtins.attrNames dirContents);
in
{
  imports = map (name: ./. + "/${name}") users;
}
