{
  ...
}:
{
  # Add widevine to helium
  # FIX -> Looks like copying contents from Brave (.config/BraveSoftware/Brave-Browser/WidevineCmd/) to Helium (.config/net.imput.helium/WidevineCmd) works for now
  # TODO -> Make the above using home-manager
  nixpkgs.overlays = [
    #(final: prev: {
    #  widevine-cdm = prev.widevine-cdm.overrideAttrs (old: {
    #    src = final.fetchurl {
    #      url = "https://edgedl.me.gvt1.com/edgedl/release2/chrome_component/bywu6vkyg6gmcthxdaetzfkptm_4.10.3050.0/oimompecagnajdejgnnjijobebaeigek_4.10.3050.0_linux_aduyhcxcs7a2znuo6ss5tffn5jpa.crx3";
    #      hash = "sha512-5Xiy7tesiH4T79VZ6RfkiOzkO+tJ20ChM8GPV7+fbtXaVDRTTnD3/Dz07v25x2YWS2VZxRPhc46JnYTXlD1Xeg==";
    #    };
    #  });
    #  helium = prev.helium.overrideAttrs (old: {
    #    postFixup = (old.postFixup or "") + ''
    #      mkdir -p "$out/opt/helium/WidevineCdm"
    #      cp -a ${final.widevine-cdm}/share/google/chrome/WidevineCdm/. \
    #            "$out/opt/helium/WidevineCdm/"
    #    '';
    #  });
    #})
  ];

  programs.helium = {
    enable = true;
  };
}
