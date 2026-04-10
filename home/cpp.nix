{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang
    clang-tools
    clang-analyzer
    gnumake cmake
    ccache
    ninja
    pkg-config
    perf
    valgrind

    (jetbrains.clion.override { forceWayland = true; })
  ];
}
