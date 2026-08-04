{
  pkgs,
  ...
}:
{
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    ly = {
      enable = true;
      enableGnomeKeyring = true;
    };
    # auto open keyring with login
    login = {
      enable = true;
      enableGnomeKeyring = true;
    };
  };

  environment.systemPackages = with pkgs; [
    seahorse
  ];
}
