{
  lib,
  self,
  ...
}:
let
  entries = builtins.attrNames (builtins.readDir ./.);
  configs = builtins.filter (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;
in
{
  flake.nixosConfigurations =
    let
      nixpkgsMap = {
        z500 = "-unstable";
      };
      systemArchMap = {
        z500 = "x86_64-linux";
	#rpi = "aarch64-linux";
      };
      myNixosSystem =
        name: self.inputs."nixpkgs${lib.attrsets.attrByPath [name] "" nixpkgsMap}".lib.nixosSystem;
    in
    lib.listToAttrs (
      builtins.map (
        name:
	lib.nameValuePair name (
	  (myNixosSystem name) {
            system = lib.attrsets.attrByPath [ name ] "x86_64-linux" systemArchMap;
	    specialArgs = {
	      inherit (self) inputs;
	      self = {
	        nixosModules = self.nixosModules;
	      };
	    };
	    modules = [
	      {
	        #nixpkgs.overlays = [
		#  self.inputs.nix-cachyos-kernel.overlays.default
		#  #self.inputs.nix-cachyos-kernel.overlays.pinned
		#];
	      }
	      #{ chaotic.nyx.overlay.enable = false; }
	      #self.inputs.chaotic.nixosModules.default
	      (./. + "/_common/default.nix")
	      (./. + "/${name}/configuration.nix")
	    ];
	  }
	)
      ) configs
    );
}
