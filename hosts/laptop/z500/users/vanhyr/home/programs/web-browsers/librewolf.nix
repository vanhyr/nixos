{
  #config,
  pkgs,
  ...
}:
{
  programs.librewolf = {
    enable = true;
    policies = {
      SecurityDevices = {
        "OpenSC PKCS#11" = "${pkgs.opensc}/lib/opensc-pkcs11.so";
        #"DNIeRemote" = "${config.programs.dnieremote.finalPackage}/lib/libdnieremotepkcs11.so"; # broken, TODO -> fix (external, not my fault)
      };
    };
    profiles.default = {
      id = 0;
    };
  };
}
