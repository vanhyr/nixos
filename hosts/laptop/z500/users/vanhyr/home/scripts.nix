{
  lib,
  ...
}:
let
  widgets_folder = ".local/bin/widgets";

  local_widgets_dir = ./scripts/widgets;
  only_regular_files = lib.filterAttrs (name: value: value == "regular") (builtins.readDir local_widgets_dir);

  scripts_map = lib.mapAttrs' (name: value: {
    name = "${widgets_folder}/${name}";
    value = {
      source = "${local_widgets_dir}/${name}";
      executable = true;
    };
  }) only_regular_files;
in
{
  home.file = scripts_map;
}
