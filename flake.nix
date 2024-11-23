{
  description = "@forsureitsme nixos setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  } @ inputs: let devicesDir = ././devices; in {
    nixosConfigurations = builtins.listToAttrs (
      map (params: {
        name = params.hostname;
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit params;};
          modules = [
            ./common.nix
            (
              if builtins.pathExists params.deviceConfigPath
              then import params.deviceConfigPath
              else {}
            )

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                users.${params.user} = import ./home.nix;

                extraSpecialArgs = {inherit params;};
              };
            }
          ];
        };
      }) (map (deviceName: rec {
        user = "piter";
        device = deviceName;
        hostname = "${user}-${device}";
        deviceConfigPath = "${devicesDir}/${device}";
      }) (nixpkgs.lib.attrNames (builtins.readDir devicesDir)))
    );
  };
}
