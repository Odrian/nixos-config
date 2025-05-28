{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.amnezia-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    unzip wget micro git
    helix rust-analyzer rustfmt nil
    flameshot

    nekoray
    nftables
    linuxKernel.packages.linux_zen.amneziawg
    amneziawg-go amneziawg-tools

    telegram-desktop discord

    gcc
    rustc cargo sccache
    neovim

    # thunderbird
    kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ amneziawg ];
}
