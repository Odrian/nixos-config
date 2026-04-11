{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup
    sccache
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
    SCCACHE_CACHE_SIZE = "10G";
  };
}
