{
  ...
}:
{
  nix = {
    settings = {
      cores = 0;
      max-jobs = "auto";
      #download-buffer-size = 4194304000; # 4GiB
      trusted-users = [ "vanhyr" ]; # root is already trusted by default, no need to add

      substituters = [
        # nix-cachyos-kernel
        #"https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        # nix-cachyos-kernel
        #"lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };
  };

}
