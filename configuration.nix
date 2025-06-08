# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports =
  [
    ./system/default.nix
    ./hardware/default.nix
    <home-manager/nixos>
  ];

  home-manager.users.catadrian = import ./home/default.nix;
}
