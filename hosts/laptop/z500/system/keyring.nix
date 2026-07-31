{
  pkgs,
  ...
}:
{
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    ly.enableGnomeKeyring = true; # enable it on ly
    login.enableGnomeKeyring = true; # auto open keyring with login
  };

  environment.systemPackages = with pkgs; [
    seahorse
  ];
}
