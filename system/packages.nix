{ config, pkgs, ... }:

let
  # Импорт flake вручную
  zen-browser-flake = builtins.getFlake "github:Gurjaka/zen-browser-nix";
  zen-browser = zen-browser-flake.packages.${pkgs.system}.default;
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # programs.firefox.enable = true;
  programs.amnezia-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    zen-browser
    telegram-desktop discord
    nekoray

    unzip wget micro
    flameshot

    nftables # for zapret
    linuxKernel.packages.linux_zen.amneziawg
    amneziawg-go amneziawg-tools

    gcc
    neovim

    # thunderbird
    kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    amneziawg
  ];
}
