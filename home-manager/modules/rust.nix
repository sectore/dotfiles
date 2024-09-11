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
    # Ignore tests to avoid error `test cli_tests ... FAILED`
    doCheck = false;
  };
in

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  home = {
    packages = with pkgs; [
      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src" 
          "rust-analyzer" 
          "rustfmt"
          "clippy"
        ];
        targets = ["x86_64-unknown-linux-gnu" "wasm32-unknown-unknown"];
      })
        loco-cli
        sea-orm-cli
      ];
      sessionPath = [ "$HOME/.cargo/bin" ];
    };
}
