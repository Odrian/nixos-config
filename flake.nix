{
  description = "Adrian flake for linux and macos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    nixops.url = "nixops";
#    nixops.nixpkgs.follows = "nixpkgs";
#    dwarffs.url = "dwarffs";
#    dwarffs.nixpkgs.follows = "nixpkgs";

    zen-browser-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = all@{ self, nixpkgs, home-manager, zen-browser-flake, ... }:
  let
    settings = import ./settings.nix;
  in
  {
    # Utilized by `nix build .`
#    defaultPackage.x86_64-linux = c-hello.defaultPackage.x86_64-linux;

    # Utilized by `nix build`
#    packages.x86_64-linux.hello = c-hello.packages.x86_64-linux.hello;

    # Utilized by `nix run .#<name>`
#    apps.x86_64-linux.hello = {
#      type = "app";
#      program = c-hello.packages.x86_64-linux.hello;
#    };

    # Utilized by `nix run . -- <args?>`
#    defaultApp.x86_64-linux = self.apps.x86_64-linux.hello;

    # Default overlay, for use in dependent flakes
#    overlay = final: prev: { };

    # # Same idea as overlay but a list or attrset of them.
#    overlays = { exampleOverlay = self.overlay; };

    # Default module, for use in dependent flakes.
    # a list or attrset of them.
#    nixosModules = { exampleModule = { config, ... }: { options = {}; config = {}; }; };

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
#      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/msi-nixos/hardware-configuration.nix
#        ./secure-boot.nix
        ./nixos/default.nix

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit zen-browser-flake;
            };
            users.${settings.username} = import ./home/_msi-nixos.nix;
          };
        }
      ];
    };
#    darwinConfigurations."macos" = darwin.lib.darwinSystem {
#      inherit system specialArgs;
#      modules = [
#        ./modules/nix-core.nix
#      ];
#    };

#    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Utilized by `nix develop`
#    devShell.x86_64-linux = rust-web-server.devShell.x86_64-linux;

    # Utilized by `nix develop .#<name>`
#    devShells.x86_64-linux.example = self.devShell.x86_64-linux;
  };
}
