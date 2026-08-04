{
  #pkgs,
  ...
}:
{
  programs.nix-ld = {
    enable = true;
    #libraries = with pkgs; [
    #  stdenv.cc.cc.lib
    #  zlib
    #  openssl
    #  curl
    #  icu
    #  libunwind
    #
    #  libxml2
    #  libxcrypt
    #];
  };
}
