{ ... }:

{
  imports = [
    ./defaults.nix
    ./packager.nix
    <home-manager/nixos>
  ];

  home-manager.users.catadrian = import ./home.nix;
}
