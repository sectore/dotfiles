{
  inputs,
  pkgs,
  ...
}: let
  rustPkgs = import pkgs.path {
    inherit (pkgs) system;
    overlays = [(import inputs.rust-overlay)];
  };
in {
  home.packages = with pkgs; [
    (rustPkgs.rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
        "rustfmt"
        "clippy"
      ];
      targets = ["x86_64-unknown-linux-gnu" "wasm32-unknown-unknown" "wasm32-wasip1"];
    })
    cargo-generate
  ];
  home.sessionPath = ["$HOME/.cargo/bin"];
}
