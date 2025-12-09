{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup
    sccache

    (jetbrains.rust-rover.override { forceWayland = true; })
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
    SCCACHE_CACHE_SIZE = "10G"; # можно указать размер кэша
  };
}
