{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src" 
        "rust-analyzer" 
        "rustfmt"
        "clippy"
      ];
      targets = ["x86_64-unknown-linux-gnu" "wasm32-unknown-unknown"];
    })
  ];
  
}
