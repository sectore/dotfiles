{ inputs, pkgs, ... }:

let
  # latest loco-cli@0.2.8
  loco-cli =  pkgs.rustPlatform.buildRustPackage rec {
    pname = "loco-cli";
    version = "0.2.8";
    src = pkgs.fetchCrate {
      inherit pname version;
      sha256 = "sha256-J02Pt+kKu8BsngHoYHpkf2RY4EHTJdO9F7uA0zvFwU0=";
    };
    cargoHash = "sha256-UagkiQ9/3xzUNXR10YY/KIlrata83FiJhIxt6WDJnQQ=";
    # Ignore tests
    # `test cli_tests ... FAILED`
    doCheck = false;
  };

  # Next dioxus-cli to fix hot-reload (desktop)
    dioxus-cli = pkgs.rustPlatform.buildRustPackage rec {
      pname = "dioxus-cli";
      name = "${pname}-git-${src.rev}";
      src = pkgs.fetchFromGitHub {
        owner = "DioxusLabs";
        repo = "dioxus";
        rev = "jk/proper-asset-crossplatform";
        sha256 = "sha256-WyMyb5m0uWkxf6MgHBr8mFDq3X5jwBh82F3ATgikI2c=";
      };
      cargoLock = {
        lockFile = "${src}/Cargo.lock";
      };

      buildAndTestSubdir = "packages/cli";

      buildInputs = with pkgs; [
        openssl
        pkg-config
      ];

      nativeBuildInputs = with pkgs; [
        pkg-config
      ];
      # don't run tests
      doCheck = false;
    };

    rustPkgs = import pkgs.path {
        inherit (pkgs) system;
        overlays = [ (import inputs.rust-overlay) ];
    };
in

{
  home = {
    packages = [
      (rustPkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
          "rustfmt"
          "clippy"
        ];
        targets = ["x86_64-unknown-linux-gnu" "wasm32-unknown-unknown"];
      })
        loco-cli
        pkgs.sea-orm-cli
        pkgs.cargo-leptos
        pkgs.leptosfmt
        dioxus-cli
      ];
      sessionPath = [ "$HOME/.cargo/bin" ];
    };
}
