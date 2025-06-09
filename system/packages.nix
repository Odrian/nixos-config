{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware.graphics.enable32Bit = true; # for Proton
  hardware.steam-hardware.enable = true; # for gamepad

  environment.systemPackages = with pkgs; [
    telegram-desktop
    discord
    yandex-music
    nekoray # vpn
    pinta # image editor

    unzip wget micro
    flameshot

    ncdu # disk usage analyzer
    gparted # disk partitioning tool

    # thunderbird
    kdePackages.kate
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];
}
