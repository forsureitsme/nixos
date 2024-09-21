{
  description = "@forsureitsme nixos setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
  let params = rec {
      user = "piter";
      device = "chromebook";
      hostname = "${user}-${device}";
  }; in {
    nixosConfigurations."${params.user}-chromebook" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit params; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.${params.user} = import ./home.nix;

            extraSpecialArgs = { inherit params; };
          };
        }
      ];
    };
  };
}
