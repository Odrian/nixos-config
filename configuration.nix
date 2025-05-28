# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# let
#   unstableTarball =
#     fetchTarball
#       https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
# in
{
  imports =
    [
      ./system.nix
    ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.amnezia-vpn.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unzip wget micro git
    helix
    flameshot

	nekoray
	nftables
	linuxKernel.packages.linux_zen.amneziawg
	amneziawg-go amneziawg-tools
    telegram-desktop
    discord

    gcc
    rustc cargo rust-analyzer sccache rustfmt
    neovim
  ];

  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
}
