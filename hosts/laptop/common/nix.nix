{
  #lib,
  ...
}:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      use-xdg-base-directories = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      #allowUnfreePredicate = (_:true); # TODO -> see how to integrate this
      nvidia.acceptLicense = true;
      #allowBroken = true; # general option, allow broken packages

      # granular allowing of broken packages
      problems.handlers = {
        nvidia-x11.broken = "warn"; # or "ignore"
        cups.broken = "warn";
      };

      # granular allowing of broken packages
      #allowBrokenPredicate =
      #  pkg:
      #  builtins.elem (lib.getName pkg) [
      #    "nvidia-x11"
      #    "cups"
      #  ];
    };
  };
}
