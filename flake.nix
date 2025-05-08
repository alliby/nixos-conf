{
  description = "My NIXOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs,  ...} @ inputs:{
    nixosConfigurations.unix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./host ];
    };
  };
}
