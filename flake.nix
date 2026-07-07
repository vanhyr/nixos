{
  description = "NixOS";

  inputs = {

    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # chaotic-nyx -> provides the cachyos kernel and some bleeding edge packages (lto does not work)
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # nix-cachyos-kernel, provides just the cachyos kernel (lto does not work)
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    #nur = {
    #  url = "github:nix-community/NUR";
    #  inputs.nixpkgs-lib.follows = "nixpkgs";
    #};

    #home-manager = {
    #  url = "github:nix-community/home-manager";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #  #url = "github:nix-community/home-manager/release-25.11";
    #  #inputs.nixpkgs-lib.follows = "nixpkgs";
    #};

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #agenix = {
    #  url = "github:ryantm/agenix";
    #  inputs.nixpkgs-lib.follows = "nixpkgs";
    #};

    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs-lib.follows = "nixpkgs";
    #};

    # oxcl complete flake (module, home manager, declarative) -> helium browser
    helium-browser = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # alvaroparker helium derivation (simpler, not declarative, no module, just the pkg) -> helium browser
    #helium = {
    #  url = "github:AlvaroParker/helium-nix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  };

  outputs =
    inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        imports = [
          #./hosts/desktop
          ./hosts/laptop
          #./hosts/server
          ./modules/devshell.nix
        ];
        _module.args.rootPath = ./.;
      }
    );
}
