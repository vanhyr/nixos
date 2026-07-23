{
  pkgs,
  ...
}:
{
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    ly.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    seahorse
  ];
}
