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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware.graphics.enable32Bit = true; # for Proton
  hardware.steam-hardware.enable = true; # for gamepad

  environment.systemPackages = with pkgs; [
    zen-browser
    telegram-desktop discord
    nekoray # vpn

    unzip wget micro
    flameshot
    ncdu # disk usage analyzer

    nftables # for zapret
    linuxKernel.packages.linux_zen.amneziawg
    amneziawg-go amneziawg-tools

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
