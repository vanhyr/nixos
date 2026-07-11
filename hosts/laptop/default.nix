{
  lib,
  self,
  ...
}:
let
  entries = builtins.attrNames (builtins.readDir ./.);
  configs = builtins.filter (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;

  homeManagerCfg = userPackages: extraImports: {
    home-manager.useUserPackages = lib.mkDefault userPackages;
    home-manager.useGlobalPkgs = false;
    home-manager.extraSpecialArgs = {
      inherit (self) inputs;
      rootPath = self;
    };
    home-manager.users.vanhyr.imports = [
      ./z500/users/vanhyr/home/home.nix
    ]
    ++ extraImports;
    home-manager.backupFileExtension = "hm-bak";
  };
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
        name: self.inputs."nixpkgs${lib.attrsets.attrByPath [ name ] "" nixpkgsMap}".lib.nixosSystem;
    in
    lib.listToAttrs (
      map (
        name:
        lib.nameValuePair name (
          (myNixosSystem name) {
            system = lib.attrsets.attrByPath [ name ] "x86_64-linux" systemArchMap;
            specialArgs = {
              inherit (self) inputs;
              rootPath = self;
              self = {
                nixosModules = self.nixosModules;
              };
            };
            modules = [
              {
                nixpkgs.overlays = [
                  # nix-cachyos-kernel
                  #self.inputs.nix-cachyos-kernel.overlays.default # works
                  #self.inputs.nix-cachyos-kernel.overlays.pinned # doesn't work with nvidia-470-patched, can't use unfree (nixConfig is fixed on the repo and can't be changed)
                ];
              }
              # chaotic-nyx
              self.inputs.chaotic.nixosModules.default
              # helium browser
              self.inputs.helium-browser.nixosModules.default
              # sops-nix
              #self.inputs.sops-nix.nixosModules.default
              self.inputs.sops-nix.nixosModules.sops
              # home-manager
              self.inputs."home-manager${
                lib.attrsets.attrByPath [ name ] "" nixpkgsMap
              }".nixosModules.home-manager
              (homeManagerCfg true [ ])
              #(homeManagerCfg false [ ])

              # imports
              (./. + "/common/default.nix")
              (./. + "/${name}/configuration.nix")
            ];
          }
        )
      ) configs
    );
}
