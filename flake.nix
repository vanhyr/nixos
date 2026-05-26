{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
