{
  pkgs,
  config,
  ...
}:
let
  #commit = "3453cd04da69c60e9330acf085746449c0a7b754";
  commit = "b1cfe45e485b76bc93cab65f4c065590004b893b";
  joanbm-patches = "https://raw.githubusercontent.com/joanbm/nvidia-470xx-linux-mainline/${commit}/patches";

  # Disable objtool for propietary blobs (optional if you are compiling the kernel)
  patch-disable-objtool-override = pkgs.fetchpatch {
    url = "${joanbm-patches}/disable-objtool-override.patch";
    hash = "sha256-3X9M13xm51lPkt0pIFxG0C4/koC1qzKsO43GATHjmK8=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
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
  patch-linux-7-2-part1 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-7.2-part1.patch";
    hash = "sha256-LO+jMpq8ZPukZUdeTyHpsRpdLQu/Nx3Vynw5nPJv+C4=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
  patch-linux-7-2-part2 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-7.2-part2.patch";
    hash = "sha256-eI5TbTaEUzH3XFYubh/vNbDsE1b84HQQ+RcTrMoGtbY=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };
  patch-linux-7-2-part3 = pkgs.fetchpatch {
    url = "${joanbm-patches}/nvidia-470xx-fix-linux-7.2-part3.patch";
    hash = "sha256-b9vDOSw5HRr7C8Dxd3TCeFll7MYnuPGQxb+lFIuligo=";
    #stripLen = 1;
    #extraPrefix = "kernel/";
  };

  baseDriver = config.boot.kernelPackages.nvidiaPackages.legacy_470;
in
baseDriver.overrideAttrs (oldAttrs: {
  # FIX -> using lto kernel needs some tinkering
  #meta = (oldAttrs.meta or { }) // {
  #  broken = false; # for the cachyos_lto kernel
  #};
  #nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.llvmPackages.clang ];
  #IGNORE_CC_MISMATCH = "1";
  #LLVM = "1";
  #CC = "clang";
  #env = (oldAttrs.env or { }) // {
  #  IGNORE_CC_MISMATCH = "1";
  #  LLVM = "1";
  #  CC = "clang";
  #};
  #preBuild = (oldAttrs.preBuild or "") + ''
  #  export IGNORE_CC_MISMATCH=1
  #  export LLVM=1
  #  export CC=clang
  #  export LD=ld.lld
  #  export AR=llvm-ar
  #  export OBJDUMP=llvm-objdump
  #  export OBJCOPY=llvm-objcopy
  #'';
  #NIX_CFLAGS_COMPILE = (oldAttrs.NIX_CFLAGS_COMPILE or "") + " -fno-lto";

  patches = (oldAttrs.patches or [ ]) ++ [
    #patch-disable-objtool-override
    #patch-linux-6-19-part1
    #patch-linux-6-19-part2
    #patch-linux-7-0
    patch-linux-7-2-part1
    patch-linux-7-2-part2
    patch-linux-7-2-part3
  ];
})
