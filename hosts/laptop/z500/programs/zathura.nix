{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    zathura
    zathuraPkgs.zathura_pdf_poppler
  ];
}
