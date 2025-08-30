{nixgl, ...}: {
  # `nixGL` config
  #  https://github.com/nix-community/home-manager/blob/master/docs/manual/usage/gpu-non-nixos.md
  nixGL.packages = nixgl.packages;
  nixgl.defaultWrapper = "mesa";
  nixgl.offloadWrapper = "nvidia";
  nixGL.installScripts = ["mesa" "nvidia"];
}
