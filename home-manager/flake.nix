{
  description = "Home Manager configuration of jk";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      # url = "github:nix-community/nixgl";
      # TODO: Back to `main` as soon as #187 comes in.
      url = "github:nix-community/nixGL/pull/187/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."jk" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        # make inputs available to home.nix
        inherit inputs;
        # Tweak `nixGL` to handle `unfree` Nvidia packages properly
        nixgl = {
          packages = import nixgl {
            pkgs = import nixpkgs {
              inherit system;
              config = {
                # Note: `allowUnfreePredicate` has to be defined here!
                # Defining it in `modules/unfree.nix` or `modules/nixgl.nix` does not work.
                allowUnfreePredicate = pkg:
                  builtins.elem (nixpkgs.lib.getName pkg) [
                    # Unfree `nvidia`.
                    # Other unfree NVIDIA packages include `nvidia-x11`, `nvidia-settings`, `nvidia-persistenced`.
                    # ^ https://wiki.nixos.org/wiki/NVIDIA#Enabling
                    "nvidia"
                  ];
              };
            };
          };
        };
      };
    };
  };
}
