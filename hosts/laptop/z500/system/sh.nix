{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    dash
  ];
  #environment.binsh = "${pkgs.bashInteractive}/bin/sh";
  environment.binsh = "${pkgs.dash}/bin/dash"; # faster POSIX scripts execution
}
