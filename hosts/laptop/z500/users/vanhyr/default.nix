{
  pkgs,
  ...
}:
{
  users = {
    users = {
      vanhyr = {
        isNormalUser = true;
        uid = 1000;
        home = "/home/vanhyr";
        shell = pkgs.fish;
        group = "vanhyr";
        extraGroups = [
          "wheel"
          "users"
          "podman"
        ];
        #packages = with pkgs; [
        packages = [
          #tree
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF6D82y0hBm0//OEhRvm1dlrkWedmCwhKSACPRxzYJ6 vanhyr@w11-redlack"
        ];
      };
    };
    groups = {
      vanhyr = {
        gid = 1000;
      };
    };
  };
}
