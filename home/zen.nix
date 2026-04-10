{ pkgs, ... }:

let
  zen-browser-flake = builtins.getFlake "github:0xc000022070/zen-browser-flake";
  zen-browser = zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    zen-browser
  ];
}
