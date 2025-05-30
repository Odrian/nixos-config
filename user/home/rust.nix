{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rust-analyzer clippy rustfmt
    rustc cargo sccache
    sccache
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
    SCCACHE_CACHE_SIZE = "10G"; # можно указать размер кэша
  };
}
