{ config, pkgs, ... }:

let
  settings = import ../settings.nix;
  username = settings.username;
  pkgs-unstable = import <nixpkgs-unstable> { config = { allowUnfree = true; }; };
in {
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

  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru

    telegram-desktop
    # discord
    pkgs-unstable.yandex-music
    throne # vpn
    pinta # image editor
    python3

    unzip wget micro tree
    flameshot

    kdePackages.filelight # disk usage analyzer
    gparted # disk partitioning tool

    sbctl niv # for secure boot

    # thunderbird
    kdePackages.kate
    gnome-system-monitor
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];
}
