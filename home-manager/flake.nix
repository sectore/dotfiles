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
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Iris (PureScript), built from source. No `follows` on purpose: Iris keeps
    # the nixpkgs pinned by purescript-iris-nix, so nixpkgs updates here don't
    # rebuild it. Upgrade with `nix flake update purescript-iris-nix`.
    purescript-iris-nix.url = "github:sectore/purescript-iris-nix";
    nixgl = {
      # url = "github:nix-community/nixgl";
      # TODO: Back to `main` as soon as #226 comes in. Pinned to a commit (checked 25-09-26).
      url = "github:catouc/nixGL/83a154719e5d8f68f89e5148d123dcb129b976c3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://nix-community.github.io/nixpkgs-update/
    nixpkgs-update = {
      url = "github:ryantm/nixpkgs-update";
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
              # `pcre` was removed from nixpkgs (EOL), but nixGL's `checkPhase` still calls `pcregrep`.
              # Shim it with `pcre2grep`, which supports the same `-o0` usage.
              # TODO: Drop once https://github.com/nix-community/nixGL/pull/227 is merged
              # OR
              # https://github.com/nix-community/nixGL/pull/226 includes that fix
              overlays = [
                (final: _prev: {
                  pcre = final.runCommand "pcregrep-shim" {} ''
                    mkdir -p $out/bin
                    ln -s ${final.lib.getBin final.pcre2}/bin/pcre2grep $out/bin/pcregrep
                  '';
                })
              ];
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
