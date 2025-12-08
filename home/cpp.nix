{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang
    clang-tools
    clang-analyzer
    gnumake cmake
    ccache

    jetbrains.clion
  ];
}
