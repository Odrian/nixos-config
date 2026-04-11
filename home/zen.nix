{ pkgs, zen-browser-flake, ... }:

let
  zen-browser = zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [
    zen-browser
  ];
}
