{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./nixos-scripts.nix
    ./git.nix
    ./bash.nix
    ./helix.nix
    ./zen.nix

    ./rust.nix
    ./cpp.nix
  ];

  home.packages = with pkgs; [
    (jetbrains.clion.override { forceWayland = true; })
    jetbrains.rust-rover
  ];
}
