{
  pkgs,
  config,
  ...
}:
let
  #joanbm-patches = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/master/patches";
  joanbm-patches = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/4cb394a4560ac25b0bd21411e26aacbc1b59e81f/patches";

  patch-linux-6-19-part1 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-6.19-part1.patch";
    hash = "sha256-Swq82/0CMM8OMJz1BpgkuOngGio8cIrdXWuR05cZDa8=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
  patch-linux-6-19-part2 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-6.19-part2.patch";
    hash = "sha256-9ykrYEl6UH3NDvfdv5sWfFUShrdRzIqf/h+OAqijRLM=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
  patch-linux-7-0 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-7.0.patch";
    hash = "sha256-mytOoDLZe8rmM/DQNMo3TxirN1RZkwjSRamg7MfsoZg=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
  #patch-disable-objtool-override = pkgs.fetchpatch {
  #  url = "${joanbm-patches}/disable-objtool-override.patch";
  #  hash = lib.fakeHash;
  #  #stripLen = 1;
  #  #extraPrefix = "kernel/";
  #};

  baseDriver = config.boot.kernelPackages.nvidiaPackages.legacy_470;
in
baseDriver.overrideAttrs (oldAttrs: {
  patches = (oldAttrs.patches or [ ]) ++ [
    patch-linux-6-19-part1
    patch-linux-6-19-part2
    patch-linux-7-0
    #patch-disable-objtool-override
  ];
})
