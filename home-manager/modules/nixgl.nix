{nixgl, ...}: {
  # `nixGL` config
  #  https://github.com/nix-community/home-manager/blob/master/docs/manual/usage/gpu-non-nixos.md
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidia";
  nixGL.installScripts = ["mesa" "nvidia"];
}
