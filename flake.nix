{
  description = "NixOS";

  inputs = {
  
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
   
    # chaotic-nyx -> cachyos_kernel
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # nyx-loner -> cachyos_kernel
    #nyx-loner.url = "github:lonerOrz/nyx-loner";

    # nix-cachyos-kernel (doesn't work, revisit it if their ci/cd passes?)
    #nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    #nix-cachyos-kernel = {
    #  url = "github:xddxdd/nix-cachyos-kernel/release";
    #  inputs.nixpkgs.follows = "nixpkgs-unstable";
    #};
    
    #nur = {
    #  url = "github:nix-community/NUR";
    #  inputs.nixpkgs-lib.follows = "nixpkgs";
    #};
    
    #home-manager = {
    #  url = "github:nix-community/home-manager/release-25.11";
    #  inputs.nixpkgs-lib.follows = "nixpkgs";
    #};
    
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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
      #inputs.nixpkgs-lib.follows = "nixpkgs";
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
          #./modules/machines/desktop
          ./modules/machines/laptop
          #./modules/machines/server
	];
	_module.args.rootPath = ./.;
      }
    );
}
